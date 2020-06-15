From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Date: Mon, 15 Jun 2020 17:31:09 +0200
Message-ID: <20200615153109.GB28894@x1.vandijck-laurijssen.be>
References: <20200326193837.GF760@x1.vandijck-laurijssen.be>
 <AM0PR04MB542742337A89900E12A8732288CC0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200330070203.GE22500@x1.vandijck-laurijssen.be>
 <AM0PR04MB54271EA5CC205263750BDBD288CB0@AM0PR04MB5427.eurprd04.prod.outlook.com>
 <20200429084733.GA27733@x1.vandijck-laurijssen.be>
 <20200429090618.GB27733@x1.vandijck-laurijssen.be>
 <AM0PR04MB6273640802E04C4009CE5BC588830@AM0PR04MB6273.eurprd04.prod.outlook.com>
 <20200612071044.GA25294@x1.vandijck-laurijssen.be>
 <20200612074253.GB25294@x1.vandijck-laurijssen.be>
 <AM0PR04MB62731627E4FC7368DB5051D4889C0@AM0PR04MB6273.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:37268 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbgFOPbX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jun 2020 11:31:23 -0400
Content-Disposition: inline
In-Reply-To: <AM0PR04MB62731627E4FC7368DB5051D4889C0@AM0PR04MB6273.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Riemann <Felix.Riemann@sma.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Andre Kalb <Andre.Kalb@sma.de>

On ma, 15 jun 2020 11:11:17 +0000, Felix Riemann wrote:
> 
> Hi Kurt,
> 
> see below.
> 
> > -----Original Message-----
> >
> > Hi Felix,
> >
> > Next question comes up.
> > See inline.
> >
> > On vr, 12 jun 2020 09:10:44 +0200, Kurt Van Dijck wrote:
> > > Thanks for verifying,
> > >
> > > I'll take a look how that can happen.
> > >
> > > I think packet loss is better (less packets lost) than before.
> > >
> > > Kurt
> > >
> > > On wo, 10 jun 2020 08:08:28 +0000, Felix Riemann wrote:
> > > > Hi Kurt,
> > > >
> > > > > -----Original Message-----
> > > > >
> > > > > I have the impression that the recv path is covered, at least the
> > > > > null ptr would have caused issued earlier already.
> > > > > Would the problem arise in c_can_do_tx fetching a NULL echo_skb?
> > > >
> > > > It really looks like it.
> > > >
> > > > Adding a BUG_ON to the loop in c_can_do_tx triggers with a NULL skb
> > returned by __can_get_echo_skb().
> > > >
> > > > For testing I replaced the BUG_ON with a check that skips the skb if that
> > happens (not sure if that would be a valid fix in that place):
> > > >
> > > > while ((obj = c_can_ffs64(pend))) {
> > > > pend &= ~((u64)1 << (obj - 1));
> > > > c_can_inval_tx_object(dev, IF_RX, obj); idx = obj -
> > > > priv->obj.send_frst; skb = __can_get_echo_skb(dev, idx, &len);
> > > > if(!skb)
> >
> > It would be interesting to know idx and priv->tx_active here.
> 
> That's the statistic over about 1600 lines I captured. First number is number of occurrences:

just double-check:
These are all when __can_get_echo_skb returned NULL?

> 
>     992 can0: Skip @ idx 0, tx_active: 0x1
>     255 can0: Skip @ idx 0, tx_active: 0x3
>     250 can0: Skip @ idx 1, tx_active: 0x2
>      11 can0: Skip @ idx 0, tx_active: 0x7
>      10 can0: Skip @ idx 1, tx_active: 0x6
>       8 can0: Skip @ idx 7, tx_active: 0x80
>       8 can0: Skip @ idx 6, tx_active: 0xc0
>       8 can0: Skip @ idx 2, tx_active: 0x6
>       6 can0: Skip @ idx 1, tx_active: 0xe
>       5 can0: Skip @ idx 2, tx_active: 0x4
>       5 can0: Skip @ idx 0, tx_active: 0xf
>       4 can0: Skip @ idx 2, tx_active: 0xc
>       4 can0: Skip @ idx 0, tx_active: 0x3f
>       3 can0: Skip @ idx 6, tx_active: 0x40
>       3 can0: Skip @ idx 3, tx_active: 0xc
>       3 can0: Skip @ idx 2, tx_active: 0xfc
>       3 can0: Skip @ idx 2, tx_active: 0x3c
>       3 can0: Skip @ idx 0, tx_active: 0x1f
>       2 can0: Skip @ idx 5, tx_active: 0x3e
>       2 can0: Skip @ idx 4, tx_active: 0x3e
>       2 can0: Skip @ idx 3, tx_active: 0xf8
>       2 can0: Skip @ idx 3, tx_active: 0x3e
>       2 can0: Skip @ idx 2, tx_active: 0x3e
>       2 can0: Skip @ idx 1, tx_active: 0x3e
>       2 can0: Skip @ idx 1, tx_active: 0x1e
>       1 can0: Skip @ idx 7, tx_active: 0xf0
>       1 can0: Skip @ idx 6, tx_active: 0xf0
>       1 can0: Skip @ idx 6, tx_active: 0x78
>       1 can0: Skip @ idx 6, tx_active: 0x70
>       1 can0: Skip @ idx 5, tx_active: 0xf0
>       1 can0: Skip @ idx 5, tx_active: 0x78
>       1 can0: Skip @ idx 5, tx_active: 0x70
>       1 can0: Skip @ idx 5, tx_active: 0x38
>       1 can0: Skip @ idx 5, tx_active: 0x20
>       1 can0: Skip @ idx 4, tx_active: 0xf0
>       1 can0: Skip @ idx 4, tx_active: 0x38
>       1 can0: Skip @ idx 4, tx_active: 0x1c
>       1 can0: Skip @ idx 3, tx_active: 0xfc
>       1 can0: Skip @ idx 3, tx_active: 0xe
>       1 can0: Skip @ idx 3, tx_active: 0x8
>       1 can0: Skip @ idx 3, tx_active: 0x78
>       1 can0: Skip @ idx 3, tx_active: 0x38
>       1 can0: Skip @ idx 3, tx_active: 0x1c
>       1 can0: Skip @ idx 2, tx_active: 0xe
>       1 can0: Skip @ idx 2, tx_active: 0x7c
>       1 can0: Skip @ idx 2, tx_active: 0x1c
>       1 can0: Skip @ idx 1, tx_active: 0xfe
>       1 can0: Skip @ idx 0, tx_active: 0xff
>       1 can0: Skip @ idx 0, tx_active: 0x7f
> 
> I used atomic_read to get the value of tx_active.
> 
> Regards,
> 
> Felix
> ___________________________________________________
> 
> SMA Solar Technology AG
> Aufsichtsrat: Uwe Kleinkauf (Vorsitzender)
> Vorstand: Ulrich Hadding, Dr.-Ing. Juergen Reinert
> Handelsregister: Amtsgericht Kassel HRB 3972
> Sitz der Gesellschaft: 34266 Niestetal
> USt-ID-Nr. DE 113 08 59 54
> WEEE-Reg.-Nr. DE 95881150
> ___________________________________________________
