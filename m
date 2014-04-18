From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 1/2] net can softing: drop 'channel' sysfs attribute
Date: Fri, 18 Apr 2014 16:39:26 +0200
Message-ID: <20140418143926.GA12094@vandijck-laurijssen.be>
References: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <535039A8.1050002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:26288 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429AbaDROjg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Apr 2014 10:39:36 -0400
Content-Disposition: inline
In-Reply-To: <535039A8.1050002@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Thu, Apr 17, 2014 at 10:29:28PM +0200, Marc Kleine-Budde wrote:
> On 04/02/2014 09:17 PM, Kurt Van Dijck wrote:
> > netdev->dev_id obsoletes this property.
> > None of the remaining properties contribute to udev detection methods.
> > The regular calls for the sysfs group can thus safely be restored.
> > 
> > Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
> > ---
> >  drivers/net/can/softing/softing_main.c |   16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
> > index 65eef1e..6cfbccd 100644
> > --- a/drivers/net/can/softing/softing_main.c
> > +++ b/drivers/net/can/softing/softing_main.c
[...]
> > @@ -680,17 +669,20 @@ static int softing_netdev_register(struct net_device *netdev)
> >  {
> >  	int ret;
> >  
> > -	netdev->sysfs_groups[0] = &netdev_sysfs_group;
> >  	ret = register_candev(netdev);
> >  	if (ret) {
> >  		dev_alert(&netdev->dev, "register failed\n");
> >  		return ret;
> >  	}
> > +	if (sysfs_create_group(&netdev->dev.kobj, &netdev_sysfs_group) < 0)
> > +		netdev_alert(netdev, "sysfs group failed\n");
> > +
> 
> What is the difference between using sysfs_create_group() and
> netdev->sysfs_groups[0]?
> 

register_candev() will (indirectly) add a sysfs node
and trigger a uevent.

calling sysfs_create_group only after that implies that the uevent
is fired potentially before the attr_group is added, and your uevent
handling code will not see it.

If you introduce sysfs attributes that way that are used to
discriminate between net_devices, then a race condition is introduced.

calling sysfs_create_group before register_candev doesn't work because
the sysfs node is not yet there.

netdev->sysfs_groups was introduced (at the same time as I needed this)
to avoid the race condition: the attr_groups listed there are added
before the uevent is fired, and after the sysfs device is created.

I needed to add to sysfs_groups because I added a sysfs attribute
that indicated the channel, potentially used to identify the can net_device.

So, the answer to your question is:
The point in time relative to the uevent at which the attr_group is added.

I dropped that sysfs attribute, and so I can use the sysfs_create_group,
which is more common and therefore a better choice.

Kurt
