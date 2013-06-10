From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/2] slcanpty: /dev/tty support for tests
Date: Mon, 10 Jun 2013 20:29:11 +0200
Message-ID: <51B61AF7.901@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl> <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl> <2b96a7606efb82e512f328eb2260b4bd@beep.pl> <f4dc05d8086417bb0b0b3613a0e93311@beep.pl> <a6a53837d3a628d0a188d974acfd2597@beep.pl> <5b163f3e26b882777deae9a0f3ba248c@beep.pl> <3bdf2623dd49f435018b29b60d720a3b@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:26487 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab3FJS3N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 14:29:13 -0400
In-Reply-To: <3bdf2623dd49f435018b29b60d720a3b@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: janusz.uzycki@elproma.com.pl
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 10.06.2013 11:53, janusz.uzycki@elproma.com.pl wrote:
> Primarily I wanted to use stdin/stdout (defined as "-") but it requir=
ed
> splitted p descriptor to pin and pout... For the "-" socat can be use=
d so I
> stopped here.

:-)

Ok, which of your three patches do you suggest to be applied now?

Is the terminal flags update patch enough?

Best regards,
Oliver

>=20
> best regards
> Janusz
>=20
> W dniu 2013-06-10 11:44, janusz.uzycki@elproma.com.pl napisa=C5=82(a)=
:
>> From 4c6115b210b64cf93493c93b05f82c83a085fb73 Mon Sep 17 00:00:00 20=
01
>> From: Janusz Uzycki <j.uzycki@elproma.com.pl>
>> Date: Fri, 7 Jun 2013 23:02:13 +0200
>> Subject: [PATCH 2/2] slcanpty: /dev/tty support for tests
>>
>>
>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
>> ---
>>  slcanpty.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/slcanpty.c b/slcanpty.c
>> index f312362..b7e8ed7 100644
>> --- a/slcanpty.c
>> +++ b/slcanpty.c
>> @@ -44,6 +44,7 @@
>>  /* maximum rx buffer len: extended CAN frame with timestamp */
>>  #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
>>  #define DEVICE_NAME_PTMX "/dev/ptmx"
>> +#define DEVICE_NAME_TTY "/dev/tty"
>>
>>  #define DEBUG
>>
>> @@ -407,10 +408,13 @@ int main(int argc, char **argv)
>>                         " /dev/ttyc0 for the slcan application\n", a=
rgv[0]);
>>                 fprintf(stderr, "e.g. for pseudo-terminal '%s %s can=
0' creates"
>>                         " /dev/pts/N\n", argv[0], DEVICE_NAME_PTMX);
>> +               fprintf(stderr, "e.g. for pseudo-terminal '%s %s can=
0' uses"
>> +                       " console terminal (for testing purposes)\n"=
,
>> argv[0], DEVICE_NAME_TTY);
>>                 fprintf(stderr, "\n");
>>                 return 1;
>>         }
>>
>> +       if (strcmp(argv[1], DEVICE_NAME_TTY) !=3D 0)
>>         select_stdin =3D check_select_stdin();
>>
>>         /* open pty */
>> --=20
>> 1.7.11.3

