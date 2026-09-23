Received: from mail-vs2-f29.google.com (mail-vs2-f29.google.com [74.125.227.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C74471252
	for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152864; cv=none; b=O9sfJJsctFzIpdPrRpnJQ1gcrtgxi/uoX2RfMqT+mKo/G0P8Y6I3gef1h+x3w68b4F1vTl3z2Vya3rDGZ42x0wSwspU9KHKcTFOc3reyTUOXkPwqARu72E8UmRVvDy8XNFIu29qStNKK8loh66bzM8o8v6OEBsQcsVhHArWoEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152864; c=relaxed/simple;
	bh=2sF6HcEmIN6i9YfzqHKDXrFIWEywko+HERAlV6bYON0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLZnh/Da92q9nh1Ko5TMEY0qjU9uL4NG2rzlfsiY4g61y78C01ORQtiqi8hvYTTHgUek4pAgunLhGFQga/+iauyTOlulUaWK3CW3CeI6f56jFhRTRp/xE8/mwV25yMJSpT3PnfhPF0EhDLXYZdC5oBJbaV3jbdP5KbpB+NBmWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f29.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so446272e0c.2
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 01:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152851; x=1790757651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WH/722tAMbnl/tgB9xRugJRNbibX3vChJ1sMrdmR3wo=;
        b=c+VV40OY+PhP1yG/7tEL9d+QjWUDzqNgDbke33/b4Qn9fJjm3CkB8ASMVxJS6EkKGx
         zbCzhIUVejFMU9vZr+kdsfhf7MTIAP6K8LXKxdg/DxAGE8Ufpw9jvBHnamo2pBffjO36
         E/S3XYvzcA4+AmsXrOIfdNloyvsvkdSdeetnajl4R3sRhkbWxB26tzKHKHmK5ts9KY87
         efvVLff5jCFeOHVzYakzH+X3WnfFvgA5tmbIELhwoti4j0L/Oi9NUFj2a4LEjvWb3kks
         Go4ub2e+GnrumStLXOzOBvPk3RH4hAJxO53Kq6a+c0BSIIrPkR/+UGoBWj2uMaT25OTS
         y0hA==
X-Forwarded-Encrypted: i=1; AKwUvBwhEFV2VmO/xECna5jXpMSeSeohmf+pzHFZxd7Pgo9uaD6wAwCILaSB1xzKWWgNZidJ2r7mVPi3uf4=@vger.kernel.org
X-Gm-Message-State: AFuF++m2vY3Tk5bGxnyYaMFLjG18xWmXaK8EMfyxtLp1IizRvDaufFG2
	RfDOIV7ghAA2t8AxivWLdO1cqBr4p+pS8NwHwHYiAVPPlTQ3JysJANGY3zXS0W298Zg=
X-Gm-Gg: AYBFou1CTw1DZEAw9EJxlGYf9WuCch6BRL77cszn3/5onx+jhSGMSZoCAQW5sdSCRT5
	Z5Nz/MfcWf0fEPa13NNPAOozETYEEZQLhOq8nfpTBPi7mS2gyZtpdkCbW4RF8bA8JTuiQbTyOP7
	qlBgLs4cz8Uig1vHDO8VIfQoG3gDbjmeWCusPaKcrBOycs9lzyovi+VE8eKgCGgWvJnK5ac8nBG
	dH5/07+R7bcDj/g11T2qv7GDXmbR3Vzd0Lnnj9RommhGX3mybh1P9EoASJfm9IBCqVe1VFxNv9q
	5q0mf1kxBs3OcNlRGGrA5Ad5RObDhb5f/ZexoFkawd3Fapf08Dgx0Wi+2uaEBW8eE1BXrN9xT5v
	7UDammXcvkEhP4fG8tAD9LNxxpvd5sdoCT7zFneBUPjbvWiVt7O+26bZhsTJMt3P5ws/jXCVRJn
	TmRaLWpRmE+6lBoUKxtWiut2SqS4i5CXbP2etcIwpVP3i24cuN2pRKfnBTzK2+zJhGNUM8Okj5M
	1k/7HQT9duhACDFRArvyfiaYQNgL5/VmLielgs8wfULC9Y=
X-Received: by 2002:a05:6102:6d3:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7ac1cca5157mr1795590137.24.1790152851011;
        Wed, 23 Sep 2026 01:40:51 -0700 (PDT)
Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com. [74.125.227.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98516a3db78sm2602581241.6.2026.09.23.01.40.49
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:40:50 -0700 (PDT)
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78564313adaso243724137.3
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 01:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwi/Dk2Bf6dsgXd9sfCvztuUQoA1syPY8VgytSPceE92ijPiKifRjpHkv4kjeWiDKhH+PLuvSDT9ys=@vger.kernel.org
X-Received: by 2002:a05:6102:4b12:b0:7ab:d3f6:6225 with SMTP id
 ada2fe7eead31-7ac17ad2eaamr2011675137.0.1790152849573; Wed, 23 Sep 2026
 01:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921131951.187981-1-biju.das.jz@bp.renesas.com>
 <20260921131951.187981-3-biju.das.jz@bp.renesas.com> <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
 <TY3PR01MB11346F23E0C28056BC78DB36B86822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346F23E0C28056BC78DB36B86822@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 10:40:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUEv6721mZZ4k4hNoGViOMH2-MZjihUMMD3Lzgjx3ZXA@mail.gmail.com>
X-Gm-Features: AclHuK9ykcDd56aG5463bJ4OIjALo7IIr4gtPS0DT59s2kcKIHbEZhe-4TowiIQ
Message-ID: <CAMuHMdVUEv6721mZZ4k4hNoGViOMH2-MZjihUMMD3Lzgjx3ZXA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Chris Paterson <Chris.Paterson2@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 23 Sept 2026 at 10:19, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Mon, 21 Sept 2026 at 15:20, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Document the RZ/G3L (R9A08G046) SoC support, which reuses the RZ/G3S
> > > (R9A08G045) CANFD bindings as a fallback compatible.
> > >
> > > RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
> > > and 2 CANFD channels on RZ/G3S.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yam
> > > +++ l
> > > @@ -47,6 +47,10 @@ properties:
> > >                - renesas,r9a07g054-canfd    # RZ/V2L
> > >            - const: renesas,rzg2l-canfd     # RZ/G2L family
> > >
> > > +      - items:
> > > +          - const: renesas,r9a08g046-canfd  # RZ/G3L
> > > +          - const: renesas,r9a08g045-canfd
> >
> > I am not sure it is a good idea to use RZ/G3S as a fallback
>
> I am also 50:50 to go with either separate compatible or as a fallback.
> Looks majority is favouring for separate compatible.
>
> So, I will send next version with separate compatible ??
> even though lot of differences which are scalable like
> "renesas,r8a779h0-canfd"
>
> >
> > RZ/G3S:
> >   - Selects receive message according to 128 receive rules,
> >   - Sets the number of receive rules (0 to 128) for each channel.
>
> I believe it is a typo in RZ/G3S HW manual as RNC0[8:0] it is 9 bit
> Field unlike RZ/G2L which has 8 bit field.
>
> Since it is 9 bits, it should be 256 receive rules.
>
> > RZ/G3L;
> >   - Selects receive message according to 384 receive rules,
>
>  256 + 128 = 384 for 3 channels.

OK, such a typo would explain it.

> >   - Sets the number of receive rules (0 to 256) for each channel.
> > These differences are not explained just by the different number of channels.  However, it's not clear to
> > me what is the real impact.
> >
> > > @@ -270,6 +283,11 @@ allOf:
> > >                - renesas,r9a09g077-canfd
> > >                - renesas,rcar-gen3-canfd
> > >                - renesas,rzg2l-canfd
> > > +      not:
> >
> > Can you really stick a "not" here? Yes, apparently you can.
> > Still, I find this hard to read.
>
> Other option is
>
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: renesas,r9a08g046-canfd
>     then: {}

Hm, empty block, Perhaps it can be combined with the other RZ/G3L
check below?

>     else:
>       if:
>         properties:
>           compatible:
>             contains:
>               enum:
>                 - renesas,r9a08g045-canfd
>                 - renesas,r9a09g077-canfd
>                 - renesas,rcar-gen3-canfd
>                 - renesas,rzg2l-canfd
>       then:
>         patternProperties:
>           "^channel[2-7]$": false
>
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              const: renesas,r9a08g046-canfd
> > >      then:
> > >        patternProperties:
> > >          "^channel[2-7]$": false
> > > @@ -292,6 +310,46 @@ allOf:
> > >        patternProperties:
> > >          "^channel[6-7]$": false
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: renesas,r9a08g045-canfd
> > > +      not:
> >
> > Likewise.
> > This one can easily be restructured like
> >
> >     if: ... renesas,r9a08g046-canfd
> >         ...
> >     else: if: ... renesas,r9a08g046-canfd
> >         ...
> >
> > to improve readability.
>
> Ok.
>
> If we are taking separate compatible route, then this is not needed??

True.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
