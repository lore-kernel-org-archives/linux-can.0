From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Fri, 30 Nov 2012 07:47:29 +0100
Message-ID: <50B85681.8030502@hartkopp.net>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de> <1354197491-31205-4-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:62825 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2K3Grc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 01:47:32 -0500
In-Reply-To: <1354197491-31205-4-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 29.11.2012 14:58, Marc Kleine-Budde wrote:

> As CAN_RAW is the basic CAN protocol, switch it on by default.
> 


Hello Marc,

you are probably right, that most users will at least need CAN_RAW sockets.
But i asked myself, what the Linux distributions will do once we point out
that a specific protocol is *preferred* to be enabled?

Regards,
Oliver

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  net/can/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/Kconfig b/net/can/Kconfig
> index 0435fc4..c017121 100644
> --- a/net/can/Kconfig
> +++ b/net/can/Kconfig
> @@ -20,7 +20,7 @@ if CAN
>  
>  config CAN_RAW
>  	tristate "Raw CAN Protocol (raw access with CAN-ID filtering)"
> -	default N
> +	default y
>  	---help---
>  	  The raw CAN protocol option offers access to the CAN bus via
>  	  the BSD socket API. You probably want to use the raw socket in


