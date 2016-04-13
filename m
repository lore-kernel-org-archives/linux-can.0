From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Can bus simulator
Date: Wed, 13 Apr 2016 09:29:55 +0200
Message-ID: <201604130929.55303.pisa@cmp.felk.cvut.cz>
References: <86DFA4E2-8971-48B1-852D-82DFAFA957DF@gmail.com> <570DF1E0.7090504@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:58534 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbcDMIBl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Apr 2016 04:01:41 -0400
In-Reply-To: <570DF1E0.7090504@hartkopp.net>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kay Cee <unee0x@gmail.com>, linux-can@vger.kernel.org

On Wednesday 13 of April 2016 09:14:40 Oliver Hartkopp wrote:
> You can use the virtual CAN interfaces, see
>
> 	https://www.kernel.org/doc/Documentation/networking/can.txt
>
> Chapter 6.4

or you can emulate complete machine with CAN interfaces.
But only three SJA1000 PCI based cards are emulated till
now:

  dummy SJA1000 mapping to PCI for testing, 

  CAN bus Kvaser PCI CAN-S (single SJA1000 channel)

  and PCM-3680I PCI (dual SJA1000 channel) contributed
  by Deniz Eren some weeks ago

Git with CAN emulation for QEMU-2.4 is available at

  https://github.com/CTU-IIG/qemu/tree/merged-2.4

Some basic documentation and pointer to RTLWS article
at

  http://rtime.felk.cvut.cz/can/can-qemu/

Best wishes,

              Pavel Pisa
