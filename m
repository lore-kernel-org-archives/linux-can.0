From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: Re: exclusive access to can interface
Date: Tue, 8 Jan 2013 10:15:57 +0000
Message-ID: <5110010.jBVHvkpXL7@uschi>
References: <2412937.XVpYjfC7zz@ws-stein> <2293513.Wi876mfY7y@ws-stein>
 <50EBF024.1030507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from host24.networkinvest.de ([46.4.85.104]:39348 "EHLO
	host24.networkinvest.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab3AHK0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 05:26:04 -0500
In-Reply-To: <50EBF024.1030507@grandegger.com>
Content-Language: de-DE
Content-ID: <958C435FDC35EA4387171216D8C5B15C@portgmbh.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Am Dienstag, 8. Januar 2013, 11:08:36 schrieb Wolfgang Grandegger:
> On 01/08/2013 10:23 AM, Alexander Stein wrote:
> > Hello Marc,
> > 
> > On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
> >> On 01/07/2013 05:52 PM, Alexander Stein wrote:
> >>> is there a way to get exclusive (write) access to a CAN interface,
> >>> so
> >>> that only one bound socket can write CAN frames on the bus?
> >> 
> >> No, what's the use case?
> > 
> > This was a customers request in order to prevent multiple applications
> > (or instances) to send CAN frames on a specific CAN interface at the
> > same time with the very same CAN-IDs. Concurrent reads shall still be
> > allowed!
> Application == CANopen?! It's like giving exclusive access to a network
> device. Isn't that possible? Well, at a first glance I have not found
> anything like that.
> 
> Wolfgang.

It of course should be possible to start two or more instances of a CAN or 
CANopen application. Sending out the same CAN Id  by the applications should 
inhibited by the application or the system designer starting the CAN(open) 
applications. Like in real life.
In real CAN network each of the CANopen nodes has to have different Node-Ids 
and properly configured PDOs in order to prevent sending the same CAN Id by 
different devices.
Starting two CANopen applications on a Linux box using the same physical CAN
will not disturb the CAN frames, but is wrong by design.
I see no need for the OPs request.

Regards
   Heinz
