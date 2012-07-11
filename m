From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Thu, 12 Jul 2012 00:19:40 +0200
Message-ID: <4FFDFBFC.5030803@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <201207091519.04235.pisa@cmp.felk.cvut.cz> <20120709144042.GA2671@vandijck-laurijssen.be> <23562188.349Ls0e8RT@ws-stein> <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com> <4FFB43FF.8060305@grandegger.com> <CABMxt4iM=nKdZVwvq-13ByBYUyJv_s07fWBgYe3MdfTSRg-OaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39123 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab2GKWTo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jul 2012 18:19:44 -0400
In-Reply-To: <CABMxt4iM=nKdZVwvq-13ByBYUyJv_s07fWBgYe3MdfTSRg-OaA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Linux-CAN <linux-can@vger.kernel.org>

On 07/11/2012 12:11 AM, Mohamed HAMZAOUI wrote:
> Hi,
> 
> i run cyclictest command like your description with system load at 90%
> (i use stress command  stress -t 3600 -c 1 --io 2 --vm-bytes 256M) and
> i have :
> Min 0 Avg 158 Max 334

Please create almost 100% load on all CPUs and run the test for a while
(at least an hour).

> then i create a program with timer (set to zero for increasing to
> maximum CPU load) who call periodically an empty function. This
> program have a priority 99 set using sched_setscheduler(0, SCHED_RR,
> &p);
> when i call this program cyclictest freeze and display me after a
> moment a very bigger value in Max, then i concluded that the OS
> schedule correctly the process according to the priority order.

The programm does block cyclictest becase it does have a higher
priority. That's pretty normal.

Wolfgang
