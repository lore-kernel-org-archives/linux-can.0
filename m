From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [RFC v3] c_can: improve latency and avoid packet loss
Date: Thu, 9 Jan 2020 13:28:23 +0100
Message-ID: <20200109122823.GB6633@x1.vandijck-laurijssen.be>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com>
 <20200107190655.GA17976@x1.vandijck-laurijssen.be>
 <CAHChkru-9uYo1wrdf8PQUv3AQcsQCag7PR7TCsR3g2xEoHjbzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:40473 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgAIM23 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jan 2020 07:28:29 -0500
Content-Disposition: inline
In-Reply-To: <CAHChkru-9uYo1wrdf8PQUv3AQcsQCag7PR7TCsR3g2xEoHjbzA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org

> > On di, 07 jan 2020 10:58:26 -0600, Elenita Hinds wrote:
> > > Hi,
> > > I've been testing version 4 of this patch series on our product and it
> > > looks good so far (only 1 packet loss at the beginning of each tests
> > > after hours of run, which is insignificant). On my end, the 64 message

Would you mind trying to run 'ip link set can0 up' with elevated
priority, ex. 'chrt -f 10 ip link ...' instead?

I had one time the idea that this would help, but it turned out that
this was not the issue I experienced, so I never investiged this
further.

Kurt
