From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI
 boards
Date: Tue, 31 Jan 2012 16:16:40 +0100
Message-ID: <4F2805D8.7090401@grandegger.com>
References: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com> <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com> <4F27EBC5.3060805@pengutronix.de> <4F280245.60809@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59418 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2AaPQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 10:16:49 -0500
In-Reply-To: <4F280245.60809@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 01/31/2012 04:01 PM, Stephane Grosjean wrote:
> Hi Marc,
> 
> What do you mean please? You want me to post 4 patches? One for each new
> board, plus one for the channels list management? For 2 of the 3 boards,
> this is as simple as adding a line into the device ids table, excepting
> the ExpressCard for which I added the management of the funky leds.
> Thanks for any clarification.

I think he wants two separate patches, instead a series of patches. One
patch for peak_pci and another for peak_pcmcia. Which does make sense as
they do not belong together.

Wolfgang.
