From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcanpty
Date: Wed, 05 Jun 2013 21:44:13 +0200
Message-ID: <51AF950D.1050004@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:10800 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab3FEToR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Jun 2013 15:44:17 -0400
In-Reply-To: <2DAB3DC2841347E7AF7833620339B427@laptop2>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Janusz Uzycki <janusz.uzycki@elproma.com.pl>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Janusz,

the slcanpty programm is just some kind of proof of concept to make applications
run, that use the slcan ASCII protocol.

E.g. http://www.port.de/en/products/canopen/diagnose/can-analyzer-can-report.html

which has the LAWICEL CAN hardware as possible hardware:

See at www.canusb.com

If you would like to have a "remote control" via IP networking for SocketCAN,
I would recommend the socketcand:

https://github.com/dschanoeh/socketcand

Please google for "socketcand", there's a video also ...

http://www.youtube.com/watch?v=6vqCu1WY2F8

Regards,
Oliver


On 05.06.2013 18:24, Janusz Uzycki wrote:
> Hi Oliver.
>  
> I want to use slcanpty as mcp251x socket-CAN to TCP server in order to check
> CAN open (via CAN festival). Do you happen to know it is good idea?
> I noticed some obstacles:
> - the program uses select() for stdin - what is a reason instead of signals?
> Some workaround is to call slcanpty /dev/ptmx can0 < /dev/ptmx & because
> /dev/null does not support select() and code finishes immediately.
> - why did you comment out filter settings M/m? What did you mean by "the
> filter is no SocketCAN filter :-(" exactly?
> - the program does not finishes if PTY was closed - errno should be checked
> otherwise the main loop runs very fast (select() does not wait)
> Good point for me is to use eg. stdin/out instead of PTY. However the program
> seems to work ok with socat's PTY.
>  
> best regards
> Janusz Uzycki
>  

