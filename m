From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH] cangen: Support RTR frames with random or increment CAN
 IDs
Date: Wed, 07 Nov 2012 10:07:08 +0100
Message-ID: <509A24BC.5070505@volkswagen.de>
References: <1352276048-21299-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:40879 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab2KGJWs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 04:22:48 -0500
In-Reply-To: <1352276048-21299-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Hello Alexander,

just yesterday evening i was pondering about making the canfd branch of the
can-utils the master branch ...

Due to added the CAN FD possibilities is also cleaned up the RTR sending
which can be done randomly now too.

See the commit log at
https://gitorious.org/linux-can/can-utils/commit/51c57c8445d5a0faef73f32fc9f5b772d4fde939

Please check out the canfd branch and see if cangen meets your requirements.

The same with 'candump' ...
There's a new '-x' option which prints extra message infos: RX/TX BRS ESI

Best regards,
Oliver

On 07.11.2012 09:14, Alexander Stein wrote:
> Signed-off-by: Alexander Stein<alexander.stein@systec-electronic.com>
> ---
>   cangen.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/cangen.c b/cangen.c
> index efb8251..0037605 100644
> --- a/cangen.c
> +++ b/cangen.c
> @@ -339,6 +339,9 @@ int main(int argc, char **argv)
>   				frame.can_id |= CAN_EFF_FLAG;
>   			} else
>   				frame.can_id&= CAN_SFF_MASK;
> +
> +			if (rtr_frame)
> +				frame.can_id |= CAN_RTR_FLAG;
>   		}
> 
>   		if (dlc_mode == MODE_RANDOM) {
> @@ -412,6 +415,9 @@ resend:
>   				frame.can_id |= CAN_EFF_FLAG;
>   			} else
>   				frame.can_id&= CAN_SFF_MASK;
> +
> +			if (rtr_frame)
> +				frame.can_id |= CAN_RTR_FLAG;
>   		}
> 
>   		if (dlc_mode == MODE_INCREMENT) {

