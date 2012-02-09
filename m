From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Antwort: Re: [Socketcan-users] socketcan in barebox bootloader
Date: Thu, 09 Feb 2012 10:32:53 +0100
Message-ID: <4F3392C5.2080409@grandegger.com>
References: <OF32B6D01B.4E8430B8-ONC125799E.0055E20B-C125799E.00563FFD@o0802.rafi.inhouse> <4F3372C3.3040902@grandegger.com> <OF323BE753.A56A00D8-ONC125799F.002F6CA3-C125799F.00302BFA@o0802.rafi.inhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58278 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2BIJj7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Feb 2012 04:39:59 -0500
In-Reply-To: <OF323BE753.A56A00D8-ONC125799F.002F6CA3-C125799F.00302BFA@o0802.rafi.inhouse>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: christian.buettner@rafi.de
Cc: linux-can@vger.kernel.org

On 02/09/2012 09:46 AM, christian.buettner@rafi.de wrote:
> Hi Wolfgang,
> 
> i know that CAN is not the best solution for this tasks, but it is a 
> requirement of a customer to use the can-bus :(
> 
> So i create a SocketCAN interface on the host side and implement a Level 2 
> CAN receiver in the bootloader, right?

Yep.

Wolfgang.

> 
> Christian
> 
> 
> 
> Von:    Wolfgang Grandegger <wg@grandegger.com>
> An:     christian.buettner@rafi.de
> Kopie:  socketcan-users@lists.berlios.de
> Datum:  09.02.2012 08:47
> Betreff:        Re: [Socketcan-users] socketcan in barebox bootloader
> 
> 
> 
> Hi Christian,
> 
> On 02/08/2012 04:42 PM, christian.buettner@rafi.de wrote:
>> Hi everyone,
>>
>> we use the i.MX28 from freescale and need a socketcan driver 
>> implementation in the barebox bootloader.
> 
> Well, a Socket-CAN implementation seems a bit heavy and overkill for a
> boot loader.
> 
>> The goal is to flash a linux or rootfs image through the barebox 
>> bootloader using a CAN bus connection.
> 
> CAN is slow! Seem not be a good idea to transfer megabytes of data that 
> way.
> 
>> We need it to make a field update of the target possible. 
>>
>> Has anyone done something like that yet?
> 
> Not that I know of.
> 
> Wolfgang.
> 
> PS:
> 
> please do not use this mailing list any longer but send your questions
> to the new "linux-can" mailing list address "linux-can@vger.kernel.org".
> For subscription or mailing list archives please have a look to:
> 
>    http://vger.kernel.org/vger-lists.html#linux-can
> 
> Mail archives of the new linux-can mailing list can be found at:
> 
>    http://dir.gmane.org/gmane.linux.can
>    http://marc.info/?l=linux-can&r=1&w=2
> 
> 
> 
> 

