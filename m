From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Thu, 21 Jan 2016 18:51:46 +0100
Message-ID: <56A11AB2.5060200@hartkopp.net>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
 <569F9588.2090809@pengutronix.de> <569F99BE.70001@peak-system.com>
 <569F9AC5.6020706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:45239 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975AbcAURwI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Jan 2016 12:52:08 -0500
In-Reply-To: <569F9AC5.6020706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 01/20/2016 03:33 PM, Marc Kleine-Budde wrote:
> On 01/20/2016 03:29 PM, Stephane Grosjean wrote:

>>
>> [ 2200.129168] peak_pci 0000:05:01.0: Warning: FW v1.2.0 needs a 
>> workaround; update is available
> 
> One per hardware device is enough.
> "Warning: FW v1.2.0 workaround active; Please update device Firmeware."
> 
> ...and a webpage displaying this message, so that you will find it.
> Maybe even add a link to the website in the commit message.
> 

searching for a potential firmware update on the PEAK Website

	http://www.peak-system.com/Firmware.180.0.html?&L=1

I did not find anything about the PCIe Hardware.

Will there be a Linux tool to apply the firmware update too?
I don't have any PCIe slots on Windows machines anymore 8-)

Best regards,
Oliver

