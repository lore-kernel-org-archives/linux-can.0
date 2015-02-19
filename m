From: =?UTF-8?Q?Maximilian_G=C3=BCntner?= <maximilian.guentner@gmail.com>
Subject: Re: Standard CAN over IP
Date: Thu, 19 Feb 2015 15:58:19 +0100
Message-ID: <CAKSnaad+G-zmSnowxN7k1zt5ijisMXvb0-Qn+FvVMnCdXEu67A@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
	<CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
	<CACsJT9M4QbYkDvQkGfhFuwA6haNyV5zesUFtLzB5VEbxP=obBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33140 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbbBSO6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Feb 2015 09:58:21 -0500
Received: by labhz20 with SMTP id hz20so83919lab.0
        for <linux-can@vger.kernel.org>; Thu, 19 Feb 2015 06:58:19 -0800 (PST)
In-Reply-To: <CACsJT9M4QbYkDvQkGfhFuwA6haNyV5zesUFtLzB5VEbxP=obBA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org, socketcan@hartkopp.net, tom_usenet@optusnet.com.au

Hi Mike,


2015-02-19 4:19 GMT+01:00 Mike Purvis <mpurvis@clearpathrobotics.com>:
> Maximilian=E2=80=94
>
> Interesting project, looks like you've made some good progress. Is th=
e
> protocol documented, or do you really only see this as suitable for u=
se
> between instances of itself?

The protocol is not documented yet (UTSL). I will add a document to
the repository within
the next few days and send an update once it is on github.

I have chosen UDP since the latency is lower compared to
TCP and it is easier to use on memory constraint platforms (think 4 KB =
RAM).
It should be pretty easy to come up with a solution for, say an Atmel
AT90CAN with
uip [1] on board.
Also, I did not include fancy features like service discovery or
setup/management
of the CAN interface since that is something I think a bridge should no=
t do.
There needs to be a separate channel for that, like ssh with proper aut=
h.

> Have you given thought to any kind of unit or end-to-end regression t=
esting
> strategies for the project?

Sure. I was thinking about writing a black box test (e.g. with python)
which checks whether
all frames sent by cangen/canplayer to vcan0 come out on vcan1 as expec=
ted, with
vcan0 connected to vcan1 using cannelloni.
In the mean time, you can manually check if everything works by
enabling frame debugging (-d cu)
and comparing the output of cangen, candump and cannelloni.

[1] https://en.wikipedia.org/wiki/UIP_(micro_IP)

Thanks,

Max

> M.
>
> On 18 February 2015 at 12:57, Maximilian G=C3=BCntner
> <maximilian.guentner@gmail.com> wrote:
>>
>> Hi all,
>>
>> 2015-02-04 21:27 GMT+01:00 Mike Purvis <mpurvis@clearpathrobotics.co=
m>:
>> > I'm interested in any proposals for how to achieve this, though th=
e
>> > idea I have in mind is basically a simple microcontroller which
>> > provides a CAN-over-UDP bridge.
>>
>> I wrote a program called cannelloni which exactly does that.
>> It creates a UDP tunnel between two SocketCAN interfaces and
>> uses a fixed timeout to aggregate the frames (e.g. 100 ms) and eithe=
r
>> sends
>> a full UDP packet once the buffer matches the MTU (which also resets
>> the timeout) or what is currently in the buffer when the timer runs =
out.
>>
>> This way you can achieve high data rates with very little overhead.
>> If you have high priority frames you can create a .csv file
>> to change the individual timeout for certain frames.
>>
>> Some features are still missing, like packet loss detection and the
>> re-transmission of lost UDP packets. CAN_FD is also not implemented.
>> Please note that cannelloni is still beta and may contain bugs.
>> =3D> Pull requests are always welcome :).
>>
>> cannelloni bridges exactly two SocketCAN interfaces over UDP. If you=
 need
>> to
>> connect more interfaces, either run multiple instances of cannelloni
>> (just change the
>> local and remote port accordingly) or "merge" multiple CAN interface=
s into
>> one vcan interface using cangw.
>>
>> You can grab cannelloni from https://github.com/mguentner/cannelloni
>>
>> Don't hesitate to contact me when you have questions!
>>
>> Thanks,
>>
>> Maximilian
>
>
