From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Mon, 23 Feb 2015 13:25:29 +0100
Message-ID: <CAKSnaaezqAXG3mNRa8zq7r1bq_YbJMHbLb1odSkaYYYDsqLi+Q@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
	<54E71DDA.9000807@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45561 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWMZb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Feb 2015 07:25:31 -0500
Received: by lbjb6 with SMTP id b6so17909316lbj.12
        for <linux-can@vger.kernel.org>; Mon, 23 Feb 2015 04:25:29 -0800 (PST)
In-Reply-To: <54E71DDA.9000807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Mike Purvis <mpurvis@clearpathrobotics.com>, linux-can@vger.kernel.org, tom_usenet@optusnet.com.au

Hi Oliver,

2015-02-20 12:43 GMT+01:00 Oliver Hartkopp <socketcan@hartkopp.net>:
> I would suggest to implement CAN FD from the beginning.
>
> When creating the CAN RAW socket just try to switch it into CAN FD mode:
>
thank you for the input. CAN FD is now (1ef0769900b) supported :)

Each instance determines whether it is possible to write CAN FD frames
to the socket, a configuration is not necessary.
In a setup where a host that uses CAN FD is connected to a host that
uses traditional CAN, frames with a payload of under 9 Bytes can also be
bridged using cannelloni - only frames that exceed 8 Bytes will be dropped.

> I wasn't able to get behind your UDP CAN frame encapsulation concept
> (missing C++ knowledge) so you definitely know better than me :-)

The protocol does not send "raw" canfd/can_frames since only the
necessary information is transmitted.
Here is how a cannelloni frame looks like:

[ VERSION | TYPE | SEQ_NO | COUNT |
                                                   COUNT * [ CANID |
LEN | LEN * DATA ] ]

To save space, the LEN attribute is used to determine how
many data bytes will follow.
The protocol has been left unchanged since LEN just gets bigger for
CAN FD frames.

As I said, I will put a document on Github with a complete documentation.

> Regards,
> Oliver

Thanks,

Maximilian
