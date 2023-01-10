%function [peakV] = calc_OCM_newfilter(stack,Tstep,Twin,Nb,taper,Smask,v,k,f,gf,gk,minvar,maxskew,minent)
%function [peakV, varB, skewB, entB] = calc_OCM_newfilter(stack,Tstep,Twin,Nb,taper,Smask,v,k,f,gf,gk)
function [peakV, varB] = calc_OCM_newfilter(stack,Tstep,Twin,Nb,taper,Smask,v,k,f,gf,gk,maxskew,minent)
    
j = 1;
peakV = NaN(1,Nb);
varB = NaN(1,Nb);
%skewB = NaN(1,Nb);
% entB = NaN(1,Nb);
% medB = NaN(1,Nb);
% meanB = NaN(1,Nb);
% kurtB = NaN(1,Nb);
for wind = 0:(Nb-1)
    % window data and construct
    cind = ((wind*Tstep)+1):((wind*Tstep)+Twin);
    block = stack(cind,:);
    
    varB(j) = var(block(:));    %find variance of block
    skewB = skewness(block(:));
    entB = entropy(rescale(block));

    if skewB > maxskew || entB < minent
        peakV(j) = NaN;
    else
        
        block = block-repmat(mean(block),Twin,1); %remove mean from block
        
        % calculate f-k spectrum
        stxfft = fft2(block.*taper);
        S = 2*stxfft.*conj(stxfft)/(Twin*length(k));
        S = fftshift(S);
        S = S(gf,gk).*Smask;
        
        % calculate v-k spectrum
        for ii = 1:length(k)
            Sv(:,ii) = interp1(f/k(ii),S(:,ii),v','linear');
        end
        
        % calculate S(v)
        V = nansum(Sv');
        V = colfilt(V,[1 5],'sliding',@mean);
        V = V/nanmax(V);  %normalized spectrum
        idxV = (V == max(V));
        
        if sum (idxV) == 1
            peakV(j) = v(idxV);
        else
            peakV(j) = NaN;
        end
        
        %     if plotFlag
        %         clf
        %         h = figure(1);
        %         subplot(221)
        %         imagesc(y,1:size(block,1)*dt,block)
        %         hold on
        %         ylabel('time (s)','fontsi',14)
        %         xlabel('y position (m)','fontsi',14)
        %         %plot([min(y) ],[])
        %         subplot(222)
        %         imagesc(f,k,log10(abs(S')))
        %         shading flat
        %         xlabel('frequency (Hz)','fontsi',14),ylabel('wavenumber (1/m)','fontsi',14)
        %         axis xy
        %         axis([-abs(fkny(1)) abs(fkny(1)) 0 fkny(2)])
        %         grid on
        %         colorbar
        %         subplot(223)
        %         imagesc(v,k,log10(abs(Sv')))
        %         shading flat
        %         colorbar
        %         xlabel('velocity (m/s)','fontsi',14),ylabel('wavenumber (1/m)','fontsi',14)
        %         axis xy
        %         %axis([min(jv) max(jv) 0 fkny(2)])
        %         grid on
        %         subplot(224)
        %         plot(v,V,'linew',1) %semilogy(v,V,'linew',1)
        %         xlabel('velocity (m/s)','fontsi',14),ylabel('wavenumber (1/m)','fontsi',14)
        %         hold on
        %         %plot(v(gind),fitted,'r--','linew',2)
        %         %plot([0 0]+dataStruct.mdlV(j),[0 1],'k','linew',2)
        %         plot([0 0]+peakV(j),[0 1],'k','linew',2) %EDITED
        %         %plot([-1 1;-1 1]*dataStruct.stdV(j)+dataStruct.mdlV(j),[0 0;1 1],'--k','linew',1)
        %         %title(dataStruct.mdlV(j))
        %         title(peakV(j))  %EDITED
        %         grid on
        %         %legend('S(v)','S_{model}(v)')
        %         legend('S(v)')
        %         if plotFlag == 2
        %             pause
        %         else
        %             drawnow
        %         end
        %     end
    end
    
    j = j+1;
    
end
end