From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: About timestamping and can-utils
Date: Thu, 06 Mar 2014 19:47:47 +0100
Message-ID: <5318C2D3.30005@hartkopp.net>
References: <53183F0E.7050309@peak-system.com> <53184641.1040506@hartkopp.net> <53185614.5040307@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:9693 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbaCFSru (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Mar 2014 13:47:50 -0500
In-Reply-To: <53185614.5040307@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 06.03.2014 12:03, Stephane Grosjean wrote:

> Meanwhile, I finally found by myself how to get the "hardware" timestamps the
> (peak_usb) driver is saving for each CAN frame it receives...

Yes. That was a quick patch that time to put the PCAN USB hw timestamp to a
less bad place :-)

> Comparing to your candump patch, there are several things a bit different I
> want to discuss about:
> 
> Your patch enables to get the (so-called) "hardware raw timestamp" as well as
> the "hardware system transformed timestamp", right ?

In the patch I was using the getnstime_raw_and_real(&tsraw, &tsreal) function
to test the syscall API. As the SJA1000 does not have any hw timestamp I just
wanted the standard sys timestamp and a monotonic clock. The latter is
important for logfiles as you don't want to have clock adjustments or clock
jumps (e.g. from ntp) in your logfile.

> 
> When I look into net/socket.c, both timestamps are copied by
> "__sock_recv_timestamp()", according to:
> 
> - SOCK_TIMESTAMPING_RAW_HARDWARE flag ("shhwtstamps->hwtstamp" is copied into
> the skb ctrlmsg)
> - SOCK_TIMESTAMPING_SYS_HARDWARE flag ("shhwtstamps->syststamp" is copied into
> the skb ctrlmsg)
> 
> If I understand well:
> 
> "hwtstamp" is the RAW timestamp received from the CAN device, without ANY
> transformation, while "syststamp" is a "system transformed hardware
> timestamp", which I understand as a timestamp the CAN device driver has
> computed (according to the "raw timestamp" for example), to be consistent with
> the system/kernel time.

That's my understanding too.

> So, a well-mannered linux-can device driver should (in case it is able to get
> hardware timestamps from its device):
> 
> - store in "hwstamp" the raw value received from the device
> - store in "syststamp" the "transformed" value the driver computes
> 
> Is it right?

Yes. But to me a

- hwtstamp (raw from the device)
- monotonic systime (just a monotonic clock)
- tstamp (standard system time - might be changed by ntp)

makes more sense.

To me it's unclear how this magic "transformation" is intended to work.
Did you find any handy description what this transformation should do?

Btw. there was a recent discussion on netdev ML where the unclear timestamp
definitions were discussed too:

http://marc.info/?t=139389972600001&r=1&w=2

Which led to this patch:
http://marc.info/?l=linux-netdev&m=139398266230777&w=2

Regards,
Oliver

