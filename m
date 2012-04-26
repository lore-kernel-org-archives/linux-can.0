From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Configuration CAN sja1000_isa
Date: Thu, 26 Apr 2012 10:03:38 +0200
Message-ID: <4F99015A.2050606@grandegger.com>
References: <CALptkFSikmR9wix-fvuD9ckxt1-PWSFQUYP3ekrZ7kL4WJ54iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34760 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2DZIDl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Apr 2012 04:03:41 -0400
In-Reply-To: <CALptkFSikmR9wix-fvuD9ckxt1-PWSFQUYP3ekrZ7kL4WJ54iQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: cedric koch-hofer <cedric.koch-hofer@snowsat.com>
Cc: linux-can@vger.kernel.org

On 04/26/2012 09:35 AM, cedric koch-hofer wrote:
> Hello all,
> 
> I am currently trying to use the CAN output of an Aaeon embedded
> system using sja1000 CAN chipset controler.
> I am using an Ubuntu with a kernel 3.0 and I do not succeed to change
> the state of my can device from down to up.
> As you can see in the following trace, all seems to work untill I try
> to activate my CAN network interface.
> After that, the interface is in state "UNKNOWN" and I can not use it
> with the socketcan tools: cansend, candump, cansniffer...
> 
> Any idea will be welcome,

That's wired. Does it work with "ifconfig can0 up"?

Wolfgang.


