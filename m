From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: can-j1939 API
Date: Tue, 29 Sep 2015 13:10:22 -0700
Message-ID: <CANGgnMZWZF7fs9HiAZMChN5RmFiAnFYZW3iiUaBE9Bjt5=tXVw@mail.gmail.com>
References: <linux-can/can-utils/pull/7@github.com> <linux-can/can-utils/pull/7/c144149208@github.com>
 <560ADC91.1090408@pengutronix.de> <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36530 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbI2UKm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 16:10:42 -0400
Received: by qkcf65 with SMTP id f65so8476736qkc.3
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2015 13:10:41 -0700 (PDT)
In-Reply-To: <20150929194920.GA11430@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On Tue, Sep 29, 2015 at 12:49 PM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> I would like to challenge other j1939 (not necessarily socketcan+can-j1939)
> users to share their opinions.
>
> > > If you look at http://elinux.org/J1939
>
> > > $ modprobe can-j1939
>
> This is a systemwide action, as opposed to
>
> > > $ ip link set can0 j1939 on
>
> which is an interface-wide action.
>
> Due to the nature of CAN, the kernel should not/cannot decide if CAN
> traffic is J1939 or not.
> Unlike other CAN protocols (RAW, BCM, ISOTP), J1939 allocates the whole
> CAN id range for its use, and using CAN ids incompatible with j1939
> is regarded illegal.
>
> So this must become a switch.
>
> The modprobe is necessary for the same reason that the sequence
>
> $ modprobe vcan
> $ ip link add vcan0 type vcan
>
> requires a modprobe too.
> I do see the weirdness of it, although this is not new.

I've been implementing J1939 in userspace with socketcan, and have
worked with a number of different vehicle types, each with their
quirks.  I haven't looked at Kurt's implementation, so take my
thoughts with a grain of salt.

J1939 allocates _most_ of the 29 bit can IDs.  The EDP bit in the
can_id signals that the message should be ignored, and any 11 bit CAN
IDs should also be ignored.  I've seen vehicles with both types of
messages on the J1939 CAN bus that I've had to work around (formats A
and B).  11 bit message IDs tend to be when system diagnostics are
happening (debugging brake ECUs, etc), though not always.  In the real
world, you won't find CAN busses which only have J1939 traffic on
them.  For the most part, you will be able to ignore the other
traffic, but not always.  The standard specifies (I can't quote
sections for you right now) that other traffic should be ignored.

Austin
