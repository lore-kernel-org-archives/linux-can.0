From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] cansniffer: totally untested hack to reduce display
 update by factor of 10
Date: Tue, 24 Jun 2014 18:38:06 +0200
Message-ID: <53A9A96E.5030407@hartkopp.net>
References: <1403627167-28287-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:56733 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbaFXQiK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 12:38:10 -0400
In-Reply-To: <1403627167-28287-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, felix.seitz@thm-motorsport.de
Cc: linux-can@vger.kernel.org

I'll check it and give a feedback.

Btw. it needs a v3:

>  /* time defaults */
>  
> -#define TIMEOUT 50 /* in 100ms */
> -#define HOLD    10 /* in 100ms */
> -#define LOOP     2 /* in 100ms */
> +#define TIMEOUT 500 /* in 10ms */
> +#define HOLD    100 /* in 10ms */
> +#define LOOP      2 /* in 10ms */

LOOP has to be *10 too.

Regards,
Oliver

