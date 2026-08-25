Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADC2F8EBC
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625676; cv=none; b=hVbHK4CQ7S5W+8w10cCovI59HdSvLqXsGJpRSED69Ie2PsfgSKEERd+smEPCHbbzrLz/tO6I0wmHdMLTXv9ya788KdO/eAxDtS8+LMoEcTdWB4K3o3/+0TSmAljwTFdsXo26mwBRGhMruhp9MZ3up+8e8cMg29rYoGVqtwB7Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625676; c=relaxed/simple;
	bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ5lj3AbX4WrVU7YiurIL20G4M3ZWGtj5bJMg4xYFwoBkS4HYS1Vqf2ueHKhFYaTfYyufAA71hoH3DGCdsRzcHFI5RywJL4YECTq609q++A+E+oBkwAvgkMIl1+MjlZm3gJFPSQaqzb7y1xTUmf3eL3UyVn57PY/rHtUQbopJ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjdF6e8N; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjdF6e8N"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66d0c8d0d6eso1239701d50.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787625673; x=1788230473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
        b=ZjdF6e8NchYkmti2HUVE6qZi/VDTpBNGxV+J6kXUp0j3c+aNqTOsuUxkC3U7CpVH1D
         qu5YHduDDHNxKz075TwqAGbXscegFrvImYWiCZQdxNp+BsIcSDorHOEC/rliLUiCt51y
         QRlWjqUYAaF3wwqb0tZg8vsfo5yggBRqP3ewiy2DYnoLU1hy1GGQhJ+boMIAU8wy3TWv
         qyaRBjKO4AGGyC+BsUpx13z62OcHZuBO71hw1p5I9OYIKxABrXwkV/cfxMcvot3z/1ut
         rziM9roXaJ86q21ku0KEw2QVnsOPSjBGlz9CvT/i+BoJyR+izZZZW74w7yWYY8AKTnIb
         mZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787625673; x=1788230473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
        b=V6VFh5Qdf7Vdl1e5u4wJ7/tsjkiarI+K+kUClxFUKRZg/KtjKwvNYaScOS8SDk7WJ9
         EYdrsmuFSRFS0XhhDXx66238SbGv3CpJq+dnWSNN6vI699v8MqVXsxG2FYBVE966THgW
         hvlUr0NazvFwGWDaAlm1JTEV8wpyQ5Tjo6zo1XGpyandHVG+y9j7vqOi2aAyxLCPMTyG
         mYD9+pDrpetYYvM1YYD4SF8w0oaI5JWg6urucISG2dQAez0jAz/l9Bkjr+YWVYsL0FUC
         L7SC5C9S98LEMNQrQnuXSBdJkajf/ATIo+V3qyuoskYiaSSTGkKLBZCDpsJzPGIMClX2
         /y9A==
X-Forwarded-Encrypted: i=1; AHgh+RpND+c8EC5t72I9elFcIvMe9UmBDU22RKv/QRaWC7xzcdnC6VMUmvxcc4F2+VUFiCggvHLH7iiDtEM=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ8ZJg+mAOmuprltz4UtywKn9ZKh//WNyhAdp6AVOmX2izP9OK
	9IhUgamDGLesFH2g8ZCQsUtNty/oYj+/E/1y5eb1/nOZnLlCAvStxaUC
X-Gm-Gg: AR+sD12JZTWZ8a4E6aiMhNcJidLAfG08D/2w51041tw0TKmcIjElGTVCrM8v8gaKe5o
	GwpUUwcjYeLZ60mIfAZljLA5aX1dBRjy6obHf6BtujV/8fcwBsDgCmUbfMW8fGkgz7xm967RDxR
	gAo273s/4nSeCAvmidgZGP8VWDBC7Opn1SCc2HnwaBSW8yi5bHhweKVEpHVCl8rhqYrJvfoa8pq
	SjBttEmQeBylA6MPB1Q92nfrKS+Zk2lx3dTp6pbeAymQTGd1HxI0uBc5btWtjw+L00wdrsMpOZg
	nbBVyWFTVnDhluZthtnH9AemQmUh/SmkislEAgj3fQXZTyvZJCuBBo1zuYtb2Z0m6PgGSbWl8lh
	L8FB0ND9som1FYJxFsMKmzWNzewWslOna0LC64PpbgTYDM/u6uL3ZyUSCL+IJoaAYlCseta+s4A
	vO7QJ8mvYUv3+0ck8Ttd3/saOlKxHh/4Ov8Iojup7Zl+Uq/cgiJYWs7MKT0F/3JUaXLdJ4Ecyl8
	I55YQ==
X-Received: by 2002:a05:690e:c4b:b0:66d:8ed:844c with SMTP id 956f58d0204a3-66d14a21d4cmr1333832d50.11.1787625673178;
        Mon, 24 Aug 2026 19:41:13 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4a2c3c2sm4773224d50.17.2026.08.24.19.41.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 19:41:12 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sashiko-bot@kernel.org
Cc: blbllhy@gmail.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Mon, 24 Aug 2026 22:41:10 -0400
Message-ID: <20260825024110.12021-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824215344.6D5751F000E9@smtp.kernel.org>
References: <20260824215344.6D5751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2026 at 03:10:26PM +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but do these error paths need to reset
> usb_rx_leftover_len to 0?

Yes. Otherwise the next transfer retries the same malformed leftover and
fails again. I will clear usb_rx_leftover_len before returning and send
v2.

> This isn't a bug introduced by this patch, but does the parser loop
> trust cmd_len without validating that it meets the minimum structural
> size expected by the command handler?

Yes. The generic parser validates framing, but not each command's minimum
structural length. That is a separate command-dispatch validation issue
and is outside the scope of this patch.

Thanks,
Cen
