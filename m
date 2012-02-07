From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: About can/usb v4 patches serie
Date: Tue, 07 Feb 2012 14:51:55 +0100
Message-ID: <4F312C7B.1020907@volkswagen.de>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F30F691.5070307@peak-system.com> <4F31238A.9060305@volkswagen.de> <4F312A9E.60506@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:44300 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab2BGNwb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2012 08:52:31 -0500
In-Reply-To: <4F312A9E.60506@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 07.02.2012 14:43, Stephane Grosjean wrote:

> Sorry for the typo but the above issue I talked about concerns the peak_pci
> driver and the PCIeC card, not the PCMCIA driver!
> So please confirm:
>
> - pciec iissue: deadlock occurs during 1xMbps traffic, afaik it occurs with
> the led timer

Yes. This problem occurs just when you set the interface to "up" with heavy 
traffic being on the bus.

> - but what about this above "eject" issue, regarding the PCMCIA cards and
> these removal notifications? Can you give me more explanations, please?

Just pull out these interfaces (both PCIeC, PCMCIA) out of the notebook 
without shutting them down before - when having full CAN rx busload.
You'll see your laptop freezing :-)

These are just some unfriendly but possible use cases from real life.

Regards,
Oliver
