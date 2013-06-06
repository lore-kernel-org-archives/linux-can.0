From: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
Subject: Re: slcanpty
Date: Thu, 6 Jun 2013 14:03:53 +0200
Message-ID: <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout15.mailmx.agnat.pl ([193.239.45.95]:35568 "EHLO
	mailmxout15.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753209Ab3FFMKR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Jun 2013 08:10:17 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

Thanks Oliver for the links. Good to know. I thought that slcanpty provides 
universal protocol for Linux/Windows.
Is it possible to configure remote CAN using socketcand to use CAN Festival 
both under Linux and Windows on PC? Is the protocol 
(https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) some 
kind of standard? What open source front-end could you advice?

best regards
Janusz

----- Original Message ----- 
From: "Oliver Hartkopp" <socketcan@hartkopp.net>
To: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
Cc: <linux-can@vger.kernel.org>
Sent: Wednesday, June 05, 2013 9:44 PM
Subject: Re: slcanpty


> Hi Janusz,
>
> the slcanpty programm is just some kind of proof of concept to make
> applications
> run, that use the slcan ASCII protocol.
>
> E.g.
> http://www.port.de/en/products/canopen/diagnose/can-analyzer-can-report.html
>
> which has the LAWICEL CAN hardware as possible hardware:
>
> See at www.canusb.com
>
> If you would like to have a "remote control" via IP networking for
> SocketCAN,
> I would recommend the socketcand:
>
> https://github.com/dschanoeh/socketcand
>
> Please google for "socketcand", there's a video also ...
>
> http://www.youtube.com/watch?v=6vqCu1WY2F8
>
> Regards,
> Oliver
>
>
> On 05.06.2013 18:24, Janusz Uzycki wrote:
>> Hi Oliver.
>>
>> I want to use slcanpty as mcp251x socket-CAN to TCP server in order to
>> check
>> CAN open (via CAN festival). Do you happen to know it is good idea?
>> I noticed some obstacles:
>> - the program uses select() for stdin - what is a reason instead of
>> signals?
>> Some workaround is to call slcanpty /dev/ptmx can0 < /dev/ptmx & because
>> /dev/null does not support select() and code finishes immediately.
>> - why did you comment out filter settings M/m? What did you mean by "the
>> filter is no SocketCAN filter :-(" exactly?
>> - the program does not finishes if PTY was closed - errno should be
>> checked
>> otherwise the main loop runs very fast (select() does not wait)
>> Good point for me is to use eg. stdin/out instead of PTY. However the
>> program
>> seems to work ok with socat's PTY.
>>
>> best regards
>> Janusz Uzycki
>>
>
>

