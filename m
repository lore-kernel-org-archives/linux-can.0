Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310728;
	b=bZV4hFQOSN6AjivlS/w3xMgKxh9cWRSDCepFvWYmoQR4L9HBPreUTgDdMCzf3gsMMtrB
	 vdWSqOvADa2YrXAHNJiVArQYIsqj+tGVxuriwIncaAyO+nh7tcMPEGUi0iIQf4Gc8oxPN
	 6lnS36x6f8lRHTja+u5Yc6ZQ8zrNdy6OWsY+QLqgugiBxkHMtiVVwKS6j0f6imO2gUufr
	 lsTdzEfESeFTWPLByn8qeifVCGnyuc0uP0dZld6iPeN3YxuTJCseD/ZsUnt3vejJnbYai
	 Rde/mMSmJZNONgLklrJf5MM8Z05QpMVDwwxxMoMOMxWOX9fG9tEhW228uiJnNlrDmIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310728;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=6I+JHeyZuaCKZLVFRW5Ed83CP01+3aMwrBoHmGNmzl8=;
	b=F8dIIfui/rea3RRhhKPG99vDPoUeQkv5pkVr+BIxbO3BB6k4zHV0BK0dC+WSJYCSLtqr
	 +4LPHl2sLOOHp/DFAa5LwIzzb+3fVY2jcVxm1QbLgUOOw7qghR9ydG6uAChU/SZ8xMuhz
	 D/Y/eJcu6oQTpwEz1fRtdHgxWVjCn9+ekSOCoYLwTmnnqRI+6gFhCW7I5Sq0vbZledTsT
	 eUZoCzgCabvC+/v2WSMXObTy1yHViRWur2w2EJNnuWDRXA63u7P0t22lfN4+nuTI7+J+N
	 3obp21Sv4mNFmQHVknVe4gsBRDXY10LOd77FNqZnd1d/0M9WltK1Vezz+JMYxOok4Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAA606A326
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 11:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FAA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99c042cee7dso849898241.1
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310726; x=1794915526;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6I+JHeyZuaCKZLVFRW5Ed83CP01+3aMwrBoHmGNmzl8=;
        b=QmyIOzeM89uXYKzrTwYvN5jhmcCUdFNIpb/5GD4SU3N17eDu3GhdlI4DTq+x8FM83I
         V9IlKXFo4cdAdUi9WWL+Tepfz7ABq4dJnlOQQVFnrmj8q3wGaaH5a1nsRhFbxvlGWY2D
         x+fXGGeo1uqbDJ4GfwAAVxYxiROLfrdrkouHXDHaEz7VKqZh77z/HbMe6dh1vripjuB2
         buXBLny2+Sdyr+rJZvjuRZWDM5nJkNy3cl/7HxFpSU3x4K3VbBTC/EygD8penTy9SwGf
         qktRpcIXZrUjWHY7wloWDsRaOE3I3CC4FZpba0CIwnvGkHcRxJEkfG0v9/UOkahkk9Td
         cM0g==
X-Forwarded-Encrypted: i=1; AL+hErHTJ0jjUGCWjPRvFAjM6tiaYtSnDP+DSRi7tqgqXmy3DOiXv8ST7voQlWsNmFUPnGyt43B+X7n9+hQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+cDCBUVgf9TgLySFtquVSlJvbrmgcJ0o7qJzGQyIcbb7cTSX8
	zLSL8EX6amQtndd9pcpfDZNwaBhcjLTXKoWMg2I4JzkTrMwOdI7aMMqBWzH0rPxGzfc=
X-Gm-Gg: AYBFou0ndH2zyKX/O+xl2yKatGcJam6OOfjqMDTPuO9HsMrgzWoXfpGauMj/UXcyH4n
	tjIrZgGiPTJgNV11sE5Wd3OkP73DOJVfV09omVJSU+kuceFm9UHYnJMuiGOBNks1l1alq4YsJsg
	zC0jS+Cc2Rq3/yY4clcqcW1ckX+dDwoNGggK5aZeWWmfjW27Tvcyfs61HU4mN6J/x5MSJT4flyN
	PFFz6fNtzjxTtDcmS5c9pEre102ZLOB29zElwpKeiSxVHJqoxLd6WtvH+AvZyaws8yS/g2GrfKJ
	fH99FL26wUJYlATF0uqANb+XH/Y53p0NZz3ZukysWbG2KyhOfUpNAdo7KsuRRr6oosfXCjcomMc
	4d1tpLt2x8/Kc6iCjDQOb9KsjepWaL3Goxzj4B8GNtJuQZokFMlb8g/FSicNntPJ1Qs+NYjQw/8
	4QUvoCkNgXiaBBGRxjKFT956aFPZhSIFl/OeiiwCtwF9ittseYj5BlMXNjSQ/xD+gNntIb7naDs
	pIWUhGcpAnjfhHG0hKftqbcCSOBIDiD4SwVMZuGK5dYhtu1+5beistQD7GjhlcNRQdtdqnaIGcM
	7Knv85d8GdlVcB7H3R+JZgTBG57e6Kdf2G6S5CdypXUhaAXhLxicFC1lwhI7QgY/mZQ3w64=
X-Received: by 2002:a05:6102:5241:b0:7ce:62a0:6a14 with SMTP id ada2fe7eead31-7d301bad091mr822700137.9.1794310726558;
        Tue, 10 Nov 2026 03:38:46 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3024d6ce1sm1519856137.11.2026.11.10.03.38.45
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:38:45 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so1106027e0c.3
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 03:38:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFYFQLlf0FLdJzwkg3Q6xnh4ID6XPQhLaONERV8sTHjdoasumfvSmNN4d7MHVpUZfCyX2o2F741s/Q=@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7d301c1a90dmr782422137.27.1794310725440; Tue, 10 Nov 2026
 03:38:45 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
 <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com> <20261110-urban-bald-mastiff-d3cc34-mkl@pengutronix.de>
In-Reply-To: <20261110-urban-bald-mastiff-d3cc34-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Nov 2026 12:38:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
X-Gm-Features: AclHuK_lxOefaCYe09vBlve1NogRGIcO0y48-fj-2S6VLM4EBEDUoZvwulW0sXI
Message-ID: <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 10 Nov 2026 at 12:28, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10.11.2026 12:08:49, Geert Uytterhoeven wrote:
> > On Tue, 29 Sept 2026 at 16:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 02.09.2026 17:15:37, Claudiu Beznea wrote:
> > > > Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
> > > > fix patch was added on the CAN driver.
> > > >
> > > > Merge strategy:
> > > > - patches 1-5/7 should go though the CAN tree
> > >
> > > Applied 1...5 to the linux-can-next tree.
> >
> > Thanks, but six weeks later they are still not visible?
> > Same for " [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict
> > resets in top-level"
> > https://lore.kernel.org/20261009-holistic-warping-puffin-3b92fe-mkl@pengutronix.de
> >
> > Am I looking at the wrong tree?
>
> I tried to get stuff into the last merge window. For various reasons it
> didn't happen. Anyways - I've pushed all queued Renesas related patches
> to the can-next/testing branch. I hope I've collected all the latest
> series. Can you have a look?

Thanks, LGTM at first sight (I guess Biju or Claudiu will scream if
something is still missing).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
