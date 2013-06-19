From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH] README: fix mainline linux typo + add linebreak
Date: Wed, 19 Jun 2013 06:01:41 +0200
Message-ID: <51C12D25.40304@universalnet.at>
References: <1371587622-21734-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:59312 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750745Ab3FSECG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 19 Jun 2013 00:02:06 -0400
In-Reply-To: <1371587622-21734-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Am 2013-06-18 22:33, schrieb Marc Kleine-Budde:
> ---
> Hello Bernd,
>
> that was my first markdown patch, doesn't look as expected :( The documentation
> says two or more tailing spaces will be converted into <br />. And I wanted to
> say mainline linux.
>
> regards,
> Marc
>
>   README.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 2b80717..8a32d0f 100644
> --- a/README.md
> +++ b/README.md
> @@ -3,7 +3,7 @@ CAN driver for UAB "8 devices" USB2CAN converter
>
>   Note
>   ----
> -The "8 devices" USB2CAN converter is supported by main linux since version 3.9.
> +The "8 devices" USB2CAN converter is supported by mainline linux since version 3.9.
>   THIS SOFTWARE COMES WITHOUT ANY WARRANTY!
>
>
>

Applied.

regards,
Bernd
