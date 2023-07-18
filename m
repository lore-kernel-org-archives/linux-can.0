Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57EEB64DD
	for <linux-can@archiver.kernel.org>; Tue, 18 Jul 2023 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGRWiz (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRWiy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 18:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315E198E;
        Tue, 18 Jul 2023 15:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9539D6126C;
        Tue, 18 Jul 2023 22:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD43C433C7;
        Tue, 18 Jul 2023 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689719933;
        bh=ft0pZeRGcxSCLViSj0gpccBQLxFThl7+npAOY8U0YXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbLHYHwJ16vjba/YKmSZ6+kQdtrhywcnd7NEm1UhXFKhq28m9ej/cfF1oAHVOozqp
         tHVNcbCaznUp2eCrx+NeRljdoOXCoHWB+0sRJQOiSVTFcQDr3GAcnKR5xl8GofAP45
         OtFqPxllJ8SxO/OYH7qAXozA/25q1J8BQ0FvQEAGGVrG8YHhL68LucWtSVQiFuALn4
         70Gvu2MFWVna7T99qYIjf3EYdpDSMk/HtZw4RwO661Ih8VN7WXwRrIcnnVXJISPHUS
         0C7MJz2/kzrzMJ7Zpl24pdn8nOqOGJmBR7WK4TtX0oIQoKdFBfgseu/Va8voylNbET
         4FUA7b0nETmpg==
Date:   Tue, 18 Jul 2023 23:38:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, Jookia <contact@jookia.org>,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/4] Add support for Allwinner D1 CAN controllers
Message-ID: <20230718-matron-backlit-ddf56c391f8a@spud>
References: <20230715112523.2533742-1-contact@jookia.org>
 <96641e09-c676-2702-149c-885002f45a64@codethink.co.uk>
 <20230718221504.GA2015343-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqqc/lv3UK4SVqTX"
Content-Disposition: inline
In-Reply-To: <20230718221504.GA2015343-robh@kernel.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cqqc/lv3UK4SVqTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 04:15:04PM -0600, Rob Herring wrote:
> On Mon, Jul 17, 2023 at 09:00:47AM +0100, Ben Dooks wrote:
> > On 15/07/2023 12:25, Jookia wrote:
> > > From: John Watts <contact@jookia.org>
> >=20
> > It would be better if you sent your sending email to be the same
> > as the from, I think you'd technically need a signed-off-by from
> > "Jookia" as well.
>=20
> The email needs to be an actual person. 'contact' doesn't appear to be=20
> one.

I don't think it is that complicated, a cursory check of the domain
suggests that "Jookia" is a nickname & there's surely nothing wrong with
not having your name in your email address.

--cqqc/lv3UK4SVqTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLcUeAAKCRB4tDGHoIJi
0gFRAP97y0ufNPfdKPAqRJk0x2B640Tp0m/2UvKiv1Kb+/FzHwEApZbMd48vDPFx
97j93TdvKGT2uC1XqbKlFQL+p1TpFgw=
=VWl0
-----END PGP SIGNATURE-----

--cqqc/lv3UK4SVqTX--
