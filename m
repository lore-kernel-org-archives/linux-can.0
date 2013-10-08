From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 08 Oct 2013 21:44:11 +0200
Message-ID: <5254608B.4080208@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com> <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60016 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab3JHToO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 15:44:14 -0400
In-Reply-To: <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On 10/08/2013 08:48 PM, Austin Schuh wrote:
> $ cat /proc/interrupts  | grep " 18:"
>  18:   23361632   96767425   20421047   23392586   IO-APIC-fasteoi
> ata_generic, can1, can0

Are both CAN active when the problem occurs. At least two handler for
the SJA1000 are called.

[105918.136861] handlers:
[105918.136962] [<ffffffff810a126f>] irq_default_primary_handler
  threaded [<ffffffffa00db857>] ata_bmdma_interrupt [libata]
[105918.136972] [<ffffffff810a126f>] irq_default_primary_handler
  threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[105918.136980] [<ffffffff810a126f>] irq_default_primary_handler
  threaded [<ffffffffa023f75e>] sja1000_interrupt [sja1000]
[105918.136981] Disabling IRQ #18

> Looks like the IRQ is shared with ata_generic.  I don't see any
> hard-drive related problems though after the message, only CAN
> problems.  If I bring the interface down and then back up with
> ifconfig, it works again.
> 
> I see this failure about once per day.

Can you use another PCI slot to have an IRQ solely for the CAN devices?

What does "ip -d -s link" list?

Does the problem show up with a vanilla (non-rt) kernel as well?

Does the problem show up if an app is reading the CAN messages?

Are you able to rebuild your kernel with some additional debug code?
(Not sure what to trigger yet, though).

Wolfgang.

