module Api
  module V1
    class SpotifyController < ApplicationController
      def show
        result = SpotifyServices::GetTrack.new('5FyxzFb5qOTtl9fCMFT20D',
                                               'BQAc9LgDXHFTzdveUC-6ZRO9E0VtMItFSf6CmV2WFRIronfTT3HRW2jqWN_U_jGAbPFE2W6kSVeN-47Vo6jlRHKKtxEfozaCigFj1RPgOv40ji61BChuUKZiSr7N1kXPzXEpC1ihL6bFe_AYpbQbwTBoDhNDSs980SaYWx7-kiGaTFrwUjc9ztzrbYklGU3eRNftwV6iq6bqQ1DJd5d87cs_PBDu3F6Lmka8DRh50_d3pmALStKwez7rRb-e5S3E8d-GwdP_6TrT2Bmw').execute
        render json: result, status: :ok
      end
    end
  end
end
