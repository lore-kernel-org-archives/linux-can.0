From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 12:38:55 +0200
Message-ID: <20170817103855.GA14908@airbook.vandijck-laurijssen.be>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
 <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
 <4c63cbf6-6634-6b57-2d6c-c9c6b3cb55c3@pengutronix.de>
 <817d02ed-45f0-d114-2043-097b8c5cf46e@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:38959 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdHQKko (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 06:40:44 -0400
Content-Disposition: inline
In-Reply-To: <817d02ed-45f0-d114-2043-097b8c5cf46e@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>


> On 08/17/2017 11:09 AM, Marc Kleine-Budde wrote:
> > On 08/17/2017 10:53 AM, Kurt Van Dijck wrote:
> >>>>> I'd like to introduce a generic j1939 address struct, it's used inside
> >>>>> the kernel only, so no userspace visible changes. What about:
> >>>>>
> >>>>>> +struct j1939_addr {
> >>>>>> +       name_t src_name;
> >>>>>> +       name_t dst_name;
> >>>>>> +       pgn_t pgn;
> >>>>>> +
> >>>>>> +       u8 sa;
> >>>>>> +       u8 da;
> >>>>>> +};
> 
> [...]
> 
> >> the max size of j1939_sk_buff_cb is limited, and using structs
> >> may consume more depending on the platform and alignment.
> >> I had troubles in the past, hence the decomposed definition.
> > 
> > We'll get a compile time error then and think of something then. :D
> 
> With that struct, it still fits into the struct j1939_sk_buff_cb on
> arm64 and amd64.
ok,
