From: janusz.uzycki@elproma.com.pl
Subject: Re: [PATCH] slcanpty
Date: Mon, 10 Jun 2013 11:16:13 +0200
Message-ID: <2b96a7606efb82e512f328eb2260b4bd@beep.pl>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
 <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
 <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl>
 <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:38838 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab3FJJQP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 05:16:15 -0400
In-Reply-To: <5dedc0b6441b754aebf3b560756932b8@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

I finally found. Here is a bug and my fix - I used bad member=20
(http://linux.die.net/man/3/termios):
         /* disable local echo which would cause double frames */
         topts.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ECHOK |
                            ECHONL | ECHOPRT | ECHOKE | ICRNL);
+       topts.c_iflag |=3D INLCR;
         tcsetattr(p, TCSANOW, &topts);
ICRNL from lflag should be also moved to "topts.c_iflag &=3D ~ICRNL;" o=
r=20
cfmakeraw() could be used.

best regards
Janusz

W dniu 2013-06-10 11:06, janusz.uzycki@elproma.com.pl napisa=C5=82(a):
> Hi Oliver.
>=20
> The patch it ok. Thanks.
> However I have a problem with "slcanpty: handle incomplete messages
> from pty correctly" patch and socat tests. The patch expects \r and
> socat by default sends only \n. Even "socat PTY,link=3D/tmp/a,crnl -"
> results in \n\n instead of \r\n in buf[] despite ICRNL flag is reset
> by tcsetattr(). Also "topts.c_lflag |=3D INLCR;" didn't help. Do you
> have idea?
>=20
> best regards
> Janusz
>=20
> W dniu 2013-06-08 13:09, Oliver Hartkopp napisa=C5=82(a):
>> Hi Janusz,
>> thanks for the patch.
>> I changed it in the way the perror() is only called on negative=20
>> return values.
>> Please check it out for a test.
>> Best regards,
>> Oliver
>> On 07.06.2013 15:40, janusz.uzycki@elproma.com.pl wrote:
>>> Hi Oliver.
>>> I've tested the following case:
>>> modprobe vcan
>>> ip link add dev vcan0 type vcan
>>> #ip link set vcan0 up type can bitrate 125000
>>> ip link set vcan0 up
>>> socat PTY,link=3D/tmp/a -
>>> cgdb --args ./slcanpty /tmp/a vcan0
>>> If socat killed slcanpty should finish instead of crazy loop (selec=
t=20
>>> always
>>> returns).
>>> Here is proposal of very little patch:
>>> From a708491ea49e170ac1d36148e75b7b6c6f07b6fd Mon Sep 17 00:00:00=20
>>> 2001
>>> From: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> Date: Fri, 7 Jun 2013 15:25:39 +0200
>>> Subject: slcanpty: detect that master PTY descriptor closed
>>>=20
>>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>>> ---
>>>  slcanpty.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/slcanpty.c b/slcanpty.c
>>> index f3628b9..061c1ab 100644
>>> --- a/slcanpty.c
>>> +++ b/slcanpty.c
>>> @@ -75,7 +75,7 @@ int pty2can(int pty, int socket, struct can_filte=
r=20
>>> *fi,
>>>         int tmp, i;
>>> nbytes =3D read(pty, &buf, sizeof(buf)-1);
>>> -       if (nbytes < 0) {
>>> +       if (nbytes <=3D 0) { /* 0 means that master PTY descriptor =
has=20
>>> been
>>> closed */
>>>                 perror("read pty");
>>>                 return 1;
>>>         }
>>> --
>>> 1.7.11.3
>>> best regards
>>> Janusz
>>>=20
