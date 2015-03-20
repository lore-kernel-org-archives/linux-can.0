From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Fri, 20 Mar 2015 17:54:39 +0100
Message-ID: <CAKSnaacWdnH7srpFXNnHX7Yhobgxc-LMnEP-rOSEq0YA=pmv9A@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35244 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbCTQyl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 12:54:41 -0400
Received: by lbcgn8 with SMTP id gn8so79582733lbc.2
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2015 09:54:39 -0700 (PDT)
In-Reply-To: <CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, tom_usenet@optusnet.com.au, Mike Purvis <mpurvis@clearpathrobotics.com>

Hi again,

cannelloni now [0] has full CAN FD support and a new alternative transport for
connections where packet loss and reordering is likely.

I decided to use SCTP instead of TCP since the original UDP packet structure
can be reused for parsing and sending using SCTP.
It also seems to be far better suited for this task and provides
interesting angles
for future use cases (out-of-bound transmits etc.).

Instead of SOCK_SEQPACKET, the implementation uses SOCK_STREAM
which appeared to be simpler to use, especially for cannelloni where some
fancy features of SCTP, like multiple associations for one socket,
are not (yet) needed.

Unlike with UDP where the connection is peer-to-peer, with SCTP one cannelloni
instance binds to an IP+port and therefore becomes a server for another
cannelloni instance which connects to it (the client). Example: [1]

While it is possible to use simultaneous init/open for SCTP connections,
it creates a lot of traffic during the initialization phase. It was
also difficult
for me to get reliable results on low latency connections (e.g.
loopback) without
continuously spamming INITs.

Other things I have fixed:

* smaller timeouts (like 100us) do not stress the CPU as much
* when a buffer is full, the oldest frame will be dropped - not the newest
  (ring buffer behavior)
* frame sorting is *disabled* by default and can be *enabled* using
the -s option

I have also added a file [2] that documents the structure of UDP/SCTP packets.

A small note on traffic control:

Applications that send whenever the write function does not return
-ENOBUFS need to be limited. This can be achieved by using a token
bucket filter [3]. There are however some limitations using this method.
If one would simply restrict the vcan interface to say 1 Mbit/s for a
remote 1 Mbit/s
physical CAN bus, both RX and TX are taken into account since the vcan interface
"repeats" everything back to other applications.
That means a TBF rate limit of 1 Mbit/s will effectively limit the interface
to 500 kbit/s.
The solution here is to double the TBF limit. However, since both CAN interfaces
are not really in-sync using cannelloni, an application might still be
sending too
fast for the actual bus on the remote host.
A very eager application like cangen -g0 -i could also suppress
a cannelloni instance.
You can not reduce the rate limit of the whole interface since cannelloni still
needs to be able to write all frames from the remote, which can reach a data
rate of up to 1 Mbit/s in this example.
One possible solution could be to put all sending/"real" applications
into a cgroup
and limit the egress traffic rate using tc. This limits applications like cangen
depending on the expected bus load of the physical bus while cannelloni is still
able to write with full speed. I haven't tried this though.
Please report back if this works for you!

I hope that you find cannelloni useful. It still needs testing but most bugs
should be fixed by now.
If you find one, please report it :)

Thanks,

Max

[0] https://github.com/mguentner/cannelloni/commit/7e59e941cd9b977ff6bbfc3389c3fc9858318e1a
[1] https://github.com/mguentner/cannelloni#sctp
[2] https://github.com/mguentner/cannelloni/blob/master/doc/udp_format.md
[3] https://github.com/mguentner/cannelloni#example
