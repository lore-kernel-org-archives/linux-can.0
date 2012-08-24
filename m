From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Fri, 24 Aug 2012 14:42:48 +0200
Message-ID: <20120824124248.GA422@vandijck-laurijssen.be>
References: <50191EA5.1040303@pengutronix.de>
 <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
 <20120824051016.GB1718@vandijck-laurijssen.be>
 <50376550.4020501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx01.eia.be ([195.130.156.18]:23483 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095Ab2HXMmv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Aug 2012 08:42:51 -0400
Content-Disposition: inline
In-Reply-To: <50376550.4020501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

On Fri, Aug 24, 2012 at 01:28:16PM +0200, Marc Kleine-Budde wrote:
> On 08/24/2012 07:10 AM, Kurt Van Dijck wrote:
> > Hello,
> > 
> > I find the CAN led triggers an interesting thing.
> > 
> > And then, this scenario fell crossed my mind:
> > Imagine I do:
> > [insert CAN device: can0]
> > $ ip link set can0 name helga
> > [insert another CAN device: again 'can0']
> > 
> > Registering 'can0-tx' led trigger will fail for the second CAN device,
> > since that led trigger name is already reserved for CAN device 'helga'.
> 
> Good point.
> 
> > I'm not sure how to fix such.
> > If 'rx' & 'tx' may be combined, reusing the netdev name may be possible?
> > Just wild thinking ...
> 
> I think the device's name (not netdev) is unique in the system and
> cannot be changed.

but may contain several netdev's ...

> 
> On my device tree enabled mx28 I'm talking about the "80032000.can" in:

You idea triggered another thougt: since control is put in device drivers,
why putting the name in the generic can_dev struct?
A more flexible approach to assign names is the key to success here.
The correct 'works in all conditions' approach is not yet in my sight :-(

Kurt
> 
> regards, Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
