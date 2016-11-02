From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Adding new CAN driver
Date: Wed, 2 Nov 2016 10:37:55 +0100
Message-ID: <1f16bce3-d285-7d93-7dca-6902bf184f88@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
 <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:35213 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbcKBJiH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 05:38:07 -0400
In-Reply-To: <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

On 11/02/2016 09:48 AM, Marc Kleine-Budde wrote:
> On 11/02/2016 08:23 AM, Kołłątaj, Remigiusz wrote:

>> I didn't get a chance to work on adding support for termination to
>> "ip". Before investing any effort I would prefer to get confirmation
>> from Oliver of Marc that the direction is right. Anyway setting up
>> termination via sysfs works just fine. It is described in readme file
>> in repository.
>
> I'd like to see a netlink interface for this. Oliver what about adding
> it to CTRL_MODE?

I would suggest to create some kind of TRX_MODE configuration instead.

The CTRL_MODE is CAN controller related (layer 2 / bitstream) while the 
transceiver is layer 1.

When creating an interface for transceivers we need to take care about 
the different power saving modes /and/ the termination.

E.g. when you have a wake-up capable transceiver you may power-down the 
entire machine when you put the TRX into sleep mode (and to wait for CAN 
traffic to switch on the power supply again).

Additionally some transceivers have the capability to switch on the 
power supply only when a specific CAN ID is seen on the CAN bus 
(selective wake-up). In fact these transceivers contain a reduced CAN 
controller with on-board clock generation to perform this kind of 
functionality.

So when we create a new netlink interface for that purpose we need to 
take care to provide a proper API.

Best regards,
Oliver
