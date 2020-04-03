From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
Date: Fri, 3 Apr 2020 09:44:26 -0500
Message-ID: <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
References: <20200403144602.8494-1-daniels@umanovskis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32952 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390751AbgDCOuQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 10:50:16 -0400
In-Reply-To: <20200403144602.8494-1-daniels@umanovskis.se>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniels Umanovskis <daniels@umanovskis.se>, linux-can@vger.kernel.org

Daniel

On 4/3/20 9:46 AM, Daniels Umanovskis wrote:
> The redundant statement seems to be a copy-paste error from other places
> in the file where the same pattern is used
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
>   drivers/net/can/m_can/tcan4x5x.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index eacd428e07e9..1065b0518c70 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -330,8 +330,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
>   
>   	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
>   				      TCAN4X5X_CLEAR_ALL_INT);
> -	if (ret)
> -		return ret;
>   

How about just returning the value of tcan4x5x_write.. and remove the 
return ret; below

Dan


>   	return ret;
>   }
