Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483997;
	b=An5Zj5H9hLx5JoKP086eJpfc0BlwGOMG0mpwoOPKoQAKzsP3hUhPNhZvbW0ZUhrp1ah/
	 j/rT9czFxmzZjPyNc9w9cpGnOri4blNcP6BjM0ThkCGIFGoaizKvs3k9tTS8R7oQ/xMkV
	 rF8lubCxvxLkgWQOaVpGqe9nx0SsWYjR7+3YDsVoZM58DjpDSAHZFytstJiq3+CHO35UR
	 PFBVcC6mOyc4j0R6o3fRY/HGJZoadZ+PAWV/1RB4qc1zpNPe8sIltfJnBojXOSEps08nN
	 uo8ysNSkr8zNx+2SrBKhe+oBhdZgKHlDoTYzwSDOqqIdT5Xmz5DTjGnt5M80gjQNv6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483997;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Kolx53a24KJUm5KZP2u9owqqcs8+ZfXKpqZQibh1BVw=;
	b=lOU2ZzZ+4/b1xIFNt+wTTgcJ3HEdwTdPypncDojAknNdmk1U+YHTh8BlMXekGGluiyx4
	 ZMPpq1WEUsz8mshP/MlMbQ4DcJQ8hlRrJwU5KP0TTWfi8W9cK25fsO2oyfhuhrd2N3uxd
	 Tnoco0hNPgSzm8wpVQHj/Zrn1taD6rDRMB+GdDZ40MzMHudWzfwxc1c1+zh6CIjYZdraU
	 V0tHuGnwqUVn6LDkgW1y4JKSyRh60BXmQmIhtAJ+G60rinCouI0XvdVjgCfEkZdX1um6b
	 P55OETgqIdnHxg3/SYYlYx77v/UXPw1qWLii/OHX1aYQfjxOAFzhJY48OvbgTQ+8aHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmBIa6zO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B5606A31E;
	Tue, 20 Oct 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmBIa6zO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C822D1F000C6;
	Tue, 20 Oct 2026 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483996;
	bh=Kolx53a24KJUm5KZP2u9owqqcs8+ZfXKpqZQibh1BVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QmBIa6zOe/FTx9F3YUSkB7CMu0VCxGvita0zo/cayueqEsHi1xj7wRQFDe1YR1D3W
	 vGwPg8NlvmA1K0RBTMFdpWIcIHuHMmoi940uGHh5aad+b8s6XlvakaHpS4pJWWjELI
	 l315XzprHxetRTlswm/56G8oFQp1tJhCEnhltFJPHrtz0HyxeYpixa8XJkbLFhT+hl
	 emgoa7f+jXsIGxsd1uX4S7ZXPmkaVP+x1FLyucVqAiA/ZGxCU9uQXEffAPM1EjrRHB
	 zohV71egnS4gUg99fZZVt3t12Yz6wwmBI9ilu5tg+AGJNjI4jtQIz+vI0s7+SLeW8S
	 nYC+059anZ1ww==
Date: Tue, 20 Oct 2026 10:13:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Message-ID: <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>

On Mon, Oct 19, 2026 at 01:02:12PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add support for Renesas RZ/G3L CANFD.
> The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 channels
> and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 192
> buffers on RZ/G3S SoC.
> 
> This patch series depend upon [1]
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?id=2b4a5055d517b11bf4a5671cef32e4d77bc45626
> 
> v4->v5:

b4 diff '20261019120220.166163-1-biju.das.jz@bp.renesas.com'
Looking up 20261019120220.166163-1-biju.das.jz@bp.renesas.com
Checking for older revisions
Grabbing search results from lore.kernel.org
---
Analyzing 5 messages in the thread
Could not find lower series to compare against.

I do not get why you keep making things difficult for review, but it's
your right. I'll skip the patch for some time.

Best regards,
Krzysztof

