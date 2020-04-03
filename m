From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
Date: Fri, 3 Apr 2020 10:04:29 -0500
Message-ID: <bee89027-bde3-ba56-f3ff-5e136fa19439@ti.com>
References: <20200403150813.10711-1-daniels@umanovskis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgDCPKW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 11:10:22 -0400
In-Reply-To: <20200403150813.10711-1-daniels@umanovskis.se>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniels Umanovskis <daniels@umanovskis.se>, linux-can@vger.kernel.org

Daniel

On 4/3/20 10:08 AM, Daniels Umanovskis wrote:
> The redundant statement seems to be a copy-paste error from other places
> in the file where the same pattern is used
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index eacd428e07e9..07f1d4a627fa 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -328,12 +328,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
> +	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
>   				      TCAN4X5X_CLEAR_ALL_INT);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
>   }
>   
>   static int tcan4x5x_init(struct m_can_classdev *cdev)


Acked-by: Dan Murphy <dmurphy@ti.com>
