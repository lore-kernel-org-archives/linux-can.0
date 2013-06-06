From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcanpty
Date: Thu, 06 Jun 2013 20:31:43 +0200
Message-ID: <51B0D58F.2010401@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:42442 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FFSbq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Jun 2013 14:31:46 -0400
In-Reply-To: <8BA0AB4D19CC422597E52513948E2EF0@laptop2>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Janusz Uzycki <janusz.uzycki@elproma.com.pl>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 06.06.2013 14:03, Janusz Uzycki wrote:
> Thanks Oliver for the links. Good to know. I thought that slcanpty provides
> universal protocol for Linux/Windows.

The SLCAN protocol is a nice and simple ASCII protocol that fits for many
purposes. But it also has some disadvantages e.g. when you want timestamps and
additional error signaling you can usually get from a CAN controller.

> Is it possible to configure remote CAN using socketcand to use CAN Festival
> both under Linux and Windows on PC?

I'm not that deep in CAN Festival, but why not? :-)

> Is the protocol
> (https://github.com/dschanoeh/socketcand/blob/master/doc/protocol.md) some
> kind of standard? What open source front-end could you advice?

The protocol has been created to have a language independent CAN access over
remote/localhost network sockets.

It was mainly intended to be used together with Java which knows PF_INET
sockets much better than PF_CAN sockets ...

See

http://kayak.2codeornot2code.org

and

http://kayak.2codeornot2code.org/tutorial.html

If you have remarks to the doc/protocol.md please feel free to discuss and
extend it.

An other open protocol for this kind of remote CAN control purpose is probably
CANAL from http://www.vscp.org/wiki/doku.php/canal - did you know it?

Best regards,
Oliver


> 
> ----- Original Message ----- From: "Oliver Hartkopp" <socketcan@hartkopp.net>
> To: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
> Cc: <linux-can@vger.kernel.org>
> Sent: Wednesday, June 05, 2013 9:44 PM
> Subject: Re: slcanpty
> 
> 
>> Hi Janusz,
>>
>> the slcanpty programm is just some kind of proof of concept to make
>> applications
>> run, that use the slcan ASCII protocol.
>>
>> E.g.
>> http://www.port.de/en/products/canopen/diagnose/can-analyzer-can-report.html
>>
>> which has the LAWICEL CAN hardware as possible hardware:
>>
>> See at www.canusb.com
>>
>> If you would like to have a "remote control" via IP networking for
>> SocketCAN,
>> I would recommend the socketcand:
>>
>> https://github.com/dschanoeh/socketcand
>>
>> Please google for "socketcand", there's a video also ...
>>
>> http://www.youtube.com/watch?v=6vqCu1WY2F8
>>
>> Regards,
>> Oliver
>>
>>
>> On 05.06.2013 18:24, Janusz Uzycki wrote:
>>> Hi Oliver.
>>>
>>> I want to use slcanpty as mcp251x socket-CAN to TCP server in order to
>>> check
>>> CAN open (via CAN festival). Do you happen to know it is good idea?
>>> I noticed some obstacles:
>>> - the program uses select() for stdin - what is a reason instead of
>>> signals?
>>> Some workaround is to call slcanpty /dev/ptmx can0 < /dev/ptmx & because
>>> /dev/null does not support select() and code finishes immediately.
>>> - why did you comment out filter settings M/m? What did you mean by "the
>>> filter is no SocketCAN filter :-(" exactly?
>>> - the program does not finishes if PTY was closed - errno should be
>>> checked
>>> otherwise the main loop runs very fast (select() does not wait)
>>> Good point for me is to use eg. stdin/out instead of PTY. However the
>>> program
>>> seems to work ok with socat's PTY.
>>>
>>> best regards
>>> Janusz Uzycki
>>>
>>
>>
> 

