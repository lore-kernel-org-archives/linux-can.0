From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Wed, 30 Apr 2014 18:35:12 +0200
Message-ID: <53612640.90106@hartkopp.net>
References: <53590FB6.6090707@tataelxsi.co.in> <20140427094418.GB28319@griso.site> <20140427180135.GB21176@vandijck-laurijssen.be> <1398760380297.91253@tataelxsi.co.in> <20140429195841.GB9737@pengutronix.de> <5360E8A6.8040204@tataelxsi.co.in> <20140430144124.GC28036@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:63099 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbaD3QfQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Apr 2014 12:35:16 -0400
In-Reply-To: <20140430144124.GC28036@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>, Robert Schwebel <r.schwebel@pengutronix.de>, John Whitmore <arigead@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 30.04.2014 16:41, Kurt Van Dijck wrote:
> Hey,
> 
> On Wed, Apr 30, 2014 at 05:42:22PM +0530, Ratheendran wrote:
>> Thanks again, I Appreciate your support, this has helped my understanding
>> ,build confidence on socketcan.
> [...]
>> Hi kurt,
>>
>> I am not able to set the timeout scenario for candump command, do i need to
>> send a killall signal to candump after a wait period.
>>
> 
> I believe this approach is a good one, but the timeout thing is the tricky part.
> I'll take a look next few days.
> 

There is already an option '-T <msecs>' for this in the latest candump on the
latest gitorious can-utils git:

Usage: candump [options] <CAN interface>+
  (use CTRL-C to terminate candump)

Options: -t <type>   (timestamp: (a)bsolute/(d)elta/(z)ero/(A)bsolute w date)
         -c          (increment color mode level)
         -i          (binary output - may exceed 80 chars/line)
         -a          (enable additional ASCII output)
         -S          (swap byte order in printed CAN data[] - marked with '`' )
         -s <level>  (silent mode - 0: off (default) 1: animation 2: silent)
         -b <can>    (bridge mode - send received frames to <can>)
         -B <can>    (bridge mode - like '-b' with disabled loopback)
         -u <usecs>  (delay bridge forwarding by <usecs> microseconds)
         -l          (log CAN-frames into file. Sets '-s 2' by default)
         -L          (use log file format on stdout)
         -n <count>  (terminate after receiption of <count> CAN frames)
         -r <size>   (set socket receive buffer to <size>)
         -d          (monitor dropped CAN frames)
         -e          (dump CAN error frames in human-readable format)
         -x          (print extra message infos, rx/tx brs esi)
         -T <msecs>  (terminate after <msecs> without any reception)

So 

	candump -T 1000 -n 4 can0 | wc -l

would produce values from 1 to 4 when there was some traffic within one
second of reception or zero when not traffic was detected.

if [ `candump -T 1000 -n 4 can0 | wc -l` -ne 0 ]; then

	echo "traffic";
else
	echo "nothing";
fi

So updating your can-utils helps :-)

Regards,
Oliver

 
