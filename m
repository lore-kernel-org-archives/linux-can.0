From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Thu, 6 Aug 2020 08:47:13 -0600
Message-ID: <20200806144713.GA829771@bogus>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
 <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa@cmp.felk.cvut.cz>
 <20200804091817.yuf6s26bclehpwwi@duo.ucw.cz>
 <20200804092021.yd3wisz3g2ed6ioe@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:39918 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgHFQmu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Aug 2020 12:42:50 -0400
Content-Disposition: inline
In-Reply-To: <20200804092021.yd3wisz3g2ed6ioe@duo.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>, pisa@cmp.felk.cvut.cz
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net, wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com

On Tue, Aug 04, 2020 at 11:20:21AM +0200, Pavel Machek wrote:
> On Tue 2020-08-04 11:18:17, Pavel Machek wrote:
> > Hi!
> > 
> > > The commit text again to make checkpatch happy.
> > 
> > ?
> > 
> > 
> > > +    oneOf:
> > > +      - items:
> > > +          - const: ctu,ctucanfd
> > > +          - const: ctu,canfd-2
> > > +      - const: ctu,ctucanfd
> > 
> > For consistency, can we have ctu,canfd-1, ctu,canfd-2?
> 
> Make it ctu,ctucanfd-1, ctu,ctucanfd-2... to make it consistent with
> the file names.

If you are going to do version numbers, please define where they come 
from. Hopefully some tag of the h/w IP version...

Better yet, put version numbers in the h/w registers itself and you 
don't need different compatibles.

Rob
