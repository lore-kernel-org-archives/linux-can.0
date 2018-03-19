From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Mon, 19 Mar 2018 07:07:05 +0100
Message-ID: <1950329.Eot9n0FZxY@ws-stein>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com> <5aeb54ba-2d96-4ab5-53c4-2d3691be7acc@gmail.com> <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <340a6c54-6031-5522-98f5-eafdd3a37a38@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Dave Taht <dave.taht@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On Friday, March 16, 2018, 11:26:47 AM CET Jakob Unterwurzacher wrote:
> On 15.03.18 23:30, John Fastabend wrote:
> >> I have reproduced it using two USB network cards connected to each other. The test tool sends UDP packets containing a counter and listens on the other interface, it is available at
> >> https://github.com/jakob-tsd/pfifo_stress/blob/master/pfifo_stress.py
> >>
> > 
> > Great thanks, can you also run this with taskset to bind to
> > a single CPU,
> > 
> >   # taskset 0x1 ./pifof_stress.py
> > 
> > And let me know if you still see the OOO.
> 
> Interesting. Looks like it depends on which core it runs on. CPU0 is 
> clean, CPU1 is not.
> 
> Clean:	taskset --cpu-list 0 ./pfifo_stress.py
> 
> Broken:	taskset --cpu-list 1 ./pfifo_stress.py
> 
> Maybe related: CPU0 is where USB interrupts are handled:
> 
> > root@rk3399-q7:~# cat /proc/interrupts           
> >            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> > 217:    2175353          0          0          0          0          0     GICv3 142 Level     xhci-hcd:usb5

This reminds me somewhat of this thread: https://marc.info/?l=linux-can&m=148007442317274&w=2

Best regards,
Alexander
