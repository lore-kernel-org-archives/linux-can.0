From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 19:51:18 +0200
Message-ID: <4FDF6A96.4050305@hartkopp.net>
References: <4FDF67C3.6020201@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30099 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2FRRvS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:51:18 -0400
In-Reply-To: <4FDF67C3.6020201@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.06.2012 19:39, Oliver Hartkopp wrote:


> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -46,18 +46,65 @@ typedef __u32 canid_t;
>   */
>  typedef __u32 can_err_mask_t;
>  +#define CAN_MAX_DLC 8
> +#define CAN_MAX_DLEN 8
> +


Hm looks broken - but the patch and the repo content is ok.

Oh, well.

Anyone an idea how to set up imap with strato.de for git send-imap with a
debian system ??

I tried this imapsslappend.pl script from

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=572521

which obviously mangles the mails a bit :-(

Regards,
Oliver

