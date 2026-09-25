Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3746EF73;
	Fri, 25 Sep 2026 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325992; cv=none; b=Aoqdu6ynuGATeQlhOyVdgoZLOw/6NZ33ozyEKRL0ZtdXcWIwXGG4ZE3x1KRaBuFV9rZvUErngO0B+oOQZXcmVcQaPtxEqkbYGGF0+ViFaos9GebukIdiMF30T2qU/jeRmx+KlseOGHA2DW15OYBHTTtrdBm8v/E6AvFGzNFY31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325992; c=relaxed/simple;
	bh=IURGtYoxegDaK44GTJ6EEdugO6hyvZxULGriSlHfoE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miZXe3yK2wg66l462Dl8LVl1BBWYtBYLcOFTusA4objqaPoebpdQSYddoMLlcIPD5+ns17gVfFvPTTD8WfGesK10iigs9L8IW1yIERYDMDJI6nNtCj6LoplCRV9k+pBEV567nf91dy7FKPQzSOz85Un2hjqFxEbl6zUBnzZTYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eccqBFgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eccqBFgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19281F00893;
	Fri, 25 Sep 2026 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790325976;
	bh=J0QQZfYuAmc7BZk41gLeKMnq/0ZAHlg+sn9OTULVhog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eccqBFgZj/ZTi0DpQHabcnuu4bvyZk6o5dejGJZaOnsmqQCI27u+QWDvrzCk+Hgbm
	 d5XZWpVVcpU+QdiEbBBX1EH4kg7z+w95J+pAUf8I3lZspQSfqzk9KBuzxbyrr7EdSf
	 mBwCOjzfP4nDfS+ZsEweb0L0ujyCWJBsQkb8B4jPGuDdHY+AAWArLheQfJhU7aKquQ
	 zYjO/7EZGIV6LrTEK0L/iry4bzbcDgp4sYIND9syajhV+kXSsVj+WIDPz+qdXcwavq
	 63ST6KZWC/0BUZ7P/nIcOt85Pp/B3eMjIIp8v1XGMfrPsIILxkcXRbVn2d9gCUrPzk
	 PUnpAKFFYEoDg==
Message-ID: <a2d77abb-99ae-44a6-867a-15c92909c750@kernel.org>
Date: Fri, 25 Sep 2026 11:46:12 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das@bp.renesas.com>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
 <20260925082134.146015-4-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260925082134.146015-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/26 11:21, Biju Das wrote:
> Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
> 11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
> RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.
> 
> Reviewed-by: Geert Uytterhoeven<geert+renesas@glider.be>
> Signed-off-by: Biju Das<biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
