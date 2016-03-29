From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: CAN message timestamping
Date: Mon, 28 Mar 2016 18:51:19 -0700
Message-ID: <CANGgnMaOs03rJByb9KVFFG1p45ZuWZ4qt8-F7y6oqtdDveNs2A@mail.gmail.com>
References: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
 <56F23F1F.6040101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34642 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbcC2Bvj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Mar 2016 21:51:39 -0400
Received: by mail-yw0-f170.google.com with SMTP id h129so2119463ywb.1
        for <linux-can@vger.kernel.org>; Mon, 28 Mar 2016 18:51:39 -0700 (PDT)
In-Reply-To: <56F23F1F.6040101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

Hi Oliver,

I spent some time trying recvmsg, but it still only gives me
timestamps with the real-time clock.  I do like the interface much
better.  Thanks!

I was able to get
  setsockopt(socket_, SOL_SOCKET, SO_TIMESTAMPNS,
      &enabled, sizeof(enabled))
and
  const int stamping_val = SOF_TIMESTAMPING_SOFTWARE |
      SOF_TIMESTAMPING_SYS_HARDWARE |
      SOF_TIMESTAMPING_RAW_HARDWARE;
  setsockopt(socket_, SOL_SOCKET, SO_TIMESTAMPING, &stamping_val,
      sizeof(stamping_val))
to successfully timestamp values with recvmsg.

I0328 18:25:09.927222 12739 can_data_source.cc:144] 0: 1459214709 927191637
I0328 18:25:09.927227 12739 can_data_source.cc:146] 1: 0 0
I0328 18:25:09.927233 12739 can_data_source.cc:148] 2: 0 0
I0328 18:25:09.927240 12739 can_data_source.cc:169] Capture time is
1459214709927191637ns

The time-stamp is definitely using the real-time clock.  The hardware
timestamps are not filled in.  Maybe I could modify the sja1000-peak
driver to abuse one of the hardware timestamps to return the timestamp
I am looking for?  I'd really rather not have to run a custom
kernel...

Austin

On Wed, Mar 23, 2016 at 12:00 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Austin,
>
> On 23.03.2016 06:12, Austin Schuh wrote:
> > We recently tried doing CAN timestamping with the ioctl(s, SIOCGSTAMP,
> > &tv) call.
>
> Did you ever try to use the recvmsg() call with enabled SO_TIMESTAMPING socket
> option?
>
> See:
>
> https://www.kernel.org/doc/Documentation/networking/timestamping.txt
> https://www.kernel.org/doc/Documentation/networking/timestamping/
>
> The candump tool also uses recvmsg() - but only with SO_TIMESTAMP so far which
> does not provide the other RX timestamps (link HW TS).
>
> Regards,
> Oliver
>
