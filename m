From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: CAN Bus over TCP/IP
Date: Wed, 18 Jun 2014 23:02:54 +0200
Message-ID: <53A1FE7E.3040909@gmail.com>
References: <20140614015522.GC9911@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:38241 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbaFRVC5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jun 2014 17:02:57 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so1418962wgg.22
        for <linux-can@vger.kernel.org>; Wed, 18 Jun 2014 14:02:55 -0700 (PDT)
In-Reply-To: <20140614015522.GC9911@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>, linux-can@vger.kernel.org

On 14.06.2014 03:55, John Whitmore wrote:
> Was contemplating something which would allow me to transmit CAN Bus frames
> over TCP/IP. Searching throws up a few papers on the subject but wondered if
> there's an OpenSource implementation already out there or any kind of spec on
> the subject. Thought there might be an RFC on the subject but haven't thrown
> up anything.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi.

Have a look at slcan and the accompanying tools (slcan_attach, ...) from
can-utils in combination with socat or a simple C-implementation that
just forwards data between a pseudo-tty and a socket. I use that setup
to connect multiple virtual machines via CAN for testing purposes.

The final setup would look like this:

candev <-> ptty <-> socat <-> tcp <-> socat <-> ptty <-> candev

I don't know what kind of performance you need, but it should definitely
be worth a look.

For example:
Machine A:
socat -d -d PTY,link=/tmp/slcan,raw TCP-LISTEN:30000 &
slcan_attach /tmp/slcan
ip link set slcan0 up

Machine B:
socat TCP:<machine-A-IP>:30000 PTY,link=/tmp/slcan
slcan_attach /tmp/slcan
ip link set slcan0 up


should connect those two CAN-Busses over TCP.

Regards
  Andre
