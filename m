From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ip -details link fails
Date: Thu, 28 May 2015 19:19:43 +0200
Message-ID: <55674E2F.7020801@hartkopp.net>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net>,<BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl> <5565FDE5.1040908@hartkopp.net>,<55661810.3050407@pengutronix.de> <BAY176-W52B59690F5605C23AA3A3D3CA0@phx.gbl>,<5567375A.404@hartkopp.net> <BAY176-W13739EF0032A532E31F9F8D3CA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:24855 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbE1RTv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 May 2015 13:19:51 -0400
In-Reply-To: <BAY176-W13739EF0032A532E31F9F8D3CA0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 28.05.2015 18:28, Ssagarr Patil wrote:
>
> write(1, "    can <TRIPLE-SAMPLING> state "..., 84    can <TRIPLE-SAMPLING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> ) = 84
> write(1, "\t  bitrate 500000 sample-point 0"..., 38       bitrate 500000 sample-point 0.875
> ) = 38
> write(1, "\t  tq 250 prop-seg 3 phase-seg1 "..., 53       tq 250 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
> ) = 53
> write(1, "\t  c_can: tseg1 2..16 tseg2 1..8"..., 64       c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
> ) = 64
> write(1, "\t  clock 20000000\n", 18       clock 20000000
> )    = 18
> exit_group(0)                           = ?
> +++ exited with 0 +++
> #

Ah, it works :-)

> But I got it working with iproute2 release 3.15.0 (ip utility, iproute2-ss140610) from [1]
> Not sure Why it fails with 4.0.0.

Ok.

Don't know either. But good to see you have a working environment now.

Regards,
Oliver

>
> [1] https://www.kernel.org/pub/linux/utils/net/iproute2/
>

