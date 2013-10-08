From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 8 Oct 2013 11:48:24 -0700
Message-ID: <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38037 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3JHSsZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 14:48:25 -0400
Received: by mail-ie0-f177.google.com with SMTP id qd12so20537764ieb.36
        for <linux-can@vger.kernel.org>; Tue, 08 Oct 2013 11:48:25 -0700 (PDT)
In-Reply-To: <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

$ cat /proc/interrupts  | grep " 18:"
 18:   23361632   96767425   20421047   23392586   IO-APIC-fasteoi
ata_generic, can1, can0

Looks like the IRQ is shared with ata_generic.  I don't see any
hard-drive related problems though after the message, only CAN
problems.  If I bring the interface down and then back up with
ifconfig, it works again.

I see this failure about once per day.

Austin

On Mon, Oct 7, 2013 at 11:58 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi,
>
> sometimes I have this 'nobody cares' problem with my Dell 6510 too. But it obviously has something to do with my USB controller. So this is probably IRQ or hardware related. Btw. if you can reproduce this problem, this might help to get behind the problem.
>
> Regards,
> Oliver
> --
> Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
