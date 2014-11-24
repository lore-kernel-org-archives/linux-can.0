From: Nicola <nicola76@inwind.it>
Subject: Re: [PATCH v1 1/3] Add documentation for SPI to CAN driver
Date: Mon, 24 Nov 2014 10:50:25 +0000 (UTC)
Message-ID: <loom.20141124T114918-639@post.gmane.org>
References: <1395404758-21977-1-git-send-email-sbabic@denx.de> <1395404758-21977-2-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48416 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaKXKzG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 24 Nov 2014 05:55:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1XsrIN-0001vV-QJ
	for linux-can@vger.kernel.org; Mon, 24 Nov 2014 11:55:03 +0100
Received: from webdefence.cluster-x.websense.net ([85.115.33.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2014 11:55:03 +0100
Received: from nicola76 by webdefence.cluster-x.websense.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2014 11:55:03 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Stefano Babic <sbabic <at> denx.de> writes:

> 
> Signed-off-by: Stefano Babic <sbabic <at> denx.de>
> 
> ---
> 
>  Documentation/networking/spi_can.txt |  707
++++++++++++++++++++++++++++++++++
>  1 file changed, 707 insertions(+)
>  create mode 100644 Documentation/networking/spi_can.txt
> 
> diff --git a/Documentation/networking/spi_can.txt
b/Documentation/networking/spi_can.txt
> new file mode 100644
> index 0000000..efd165a
> --- /dev/null
> +++ b/Documentation/networking/spi_can.txt
>  <at>  <at>  -0,0 +1,707  <at>  <at> 
> +The spi_can driver is intended to provide a general protocol
> +to support CAN interface that are not directly connected or
> +part of the main controller, but they are available on a
> +separate controller, such as a low cost/low power microcontroller
> +(for example, very simple 16 bit controllers providing multiple CAN
> + busses).
> +
> +This document is intended to describe the internal protocol
> +on the SPI interface between the linux system (main controller)
> +and the remote CAN controller(s).
> +

Dear Stefano,
I am interested in your driver, but I have some doubt about latency due to
use of only one SPI channel.
Do you have any information to share about latency point-to point added to
CAN frames (tx and rx) and CAN speed used: 1Mps, 500Kbps, 250 Kps, etc?

Thank you in advance,

Regards,
Nicola


