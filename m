Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0032C63697
	for <linux-can@archiver.kernel.org>; Sun, 22 Nov 2020 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDD820760
	for <linux-can@archiver.kernel.org>; Sun, 22 Nov 2020 02:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgKVCqZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 21 Nov 2020 21:46:25 -0500
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:57810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgKVCqZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2020 21:46:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3F9DB100E7B40;
        Sun, 22 Nov 2020 02:46:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coil29_120f78c27359
X-Filterd-Recvd-Size: 2917
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Nov 2020 02:46:22 +0000 (UTC)
Message-ID: <13a35c0a0d446b72c2f83fda1651dea924707345.camel@perches.com>
Subject: Re: [PATCH 072/141] can: peak_usb: Fix fall-through warnings for
 Clang
From:   Joe Perches <joe@perches.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Sat, 21 Nov 2020 18:46:21 -0800
In-Reply-To: <d2fc3c0e-54de-3f2a-1434-76a80847965c@pengutronix.de>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <aab7cf16bf43cc7c3e9c9930d2dae850c1d07a3c.1605896059.git.gustavoars@kernel.org>
         <bf3dbc5c-c34e-b3ef-abb6-0c88d8a90332@pengutronix.de>
         <de5b16cf3fdac1f783e291acc325b78368653ec5.camel@perches.com>
         <d2fc3c0e-54de-3f2a-1434-76a80847965c@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 2020-11-22 at 00:04 +0100, Marc Kleine-Budde wrote:
> On 11/21/20 8:50 PM, Joe Perches wrote:
> > > What about moving the default to the end if the case, which is more common anyways:
> > > 
> > > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> > []
> > > @@ -295,16 +295,16 @@ static void peak_usb_write_bulk_callback(struct urb *urb)
> > >                 netif_trans_update(netdev);
> > >                 break;
> > >  
> > > 
> > > -       default:
> > > -               if (net_ratelimit())
> > > -                       netdev_err(netdev, "Tx urb aborted (%d)\n",
> > > -                                  urb->status);
> > >         case -EPROTO:
> > >         case -ENOENT:
> > >         case -ECONNRESET:
> > >         case -ESHUTDOWN:
> > > -
> > >                 break;
> > > +
> > > +       default:
> > > +               if (net_ratelimit())
> > > +                       netdev_err(netdev, "Tx urb aborted (%d)\n",
> > > +                                  urb->status);
> > 
> > That's fine and is more generally used style but this
> > default: case should IMO also end with a break;
> > 
> > +		break;
> 
> I don't mind.
> 
> process/coding-style.rst is not totally clear about the break after the default,
> if this is the lase one the switch statement.

deprecated.rst has:

All switch/case blocks must end in one of:

* break;
* fallthrough;
* continue;
* goto <label>;
* return [expression];

I suppose that could be moved into coding-style along with
maybe a change to "all switch/case/default blocks"

