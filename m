From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Wed, 18 Feb 2015 18:57:33 +0100
Message-ID: <CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33010 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbBRR5f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Feb 2015 12:57:35 -0500
Received: by lbvp9 with SMTP id p9so2762948lbv.0
        for <linux-can@vger.kernel.org>; Wed, 18 Feb 2015 09:57:33 -0800 (PST)
In-Reply-To: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org, socketcan@hartkopp.net, tom_usenet@optusnet.com.au

Hi all,

2015-02-04 21:27 GMT+01:00 Mike Purvis <mpurvis@clearpathrobotics.com>:
> I'm interested in any proposals for how to achieve this, though the
> idea I have in mind is basically a simple microcontroller which
> provides a CAN-over-UDP bridge.

I wrote a program called cannelloni which exactly does that.
It creates a UDP tunnel between two SocketCAN interfaces and
uses a fixed timeout to aggregate the frames (e.g. 100 ms) and either sends
a full UDP packet once the buffer matches the MTU (which also resets
the timeout) or what is currently in the buffer when the timer runs out.

This way you can achieve high data rates with very little overhead.
If you have high priority frames you can create a .csv file
to change the individual timeout for certain frames.

Some features are still missing, like packet loss detection and the
re-transmission of lost UDP packets. CAN_FD is also not implemented.
Please note that cannelloni is still beta and may contain bugs.
=> Pull requests are always welcome :).

cannelloni bridges exactly two SocketCAN interfaces over UDP. If you need to
connect more interfaces, either run multiple instances of cannelloni
(just change the
local and remote port accordingly) or "merge" multiple CAN interfaces into
one vcan interface using cangw.

You can grab cannelloni from https://github.com/mguentner/cannelloni

Don't hesitate to contact me when you have questions!

Thanks,

Maximilian
