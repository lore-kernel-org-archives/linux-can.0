Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616193;
	b=oEOvJAWR3VVsaHWV0f5/O9qSQK5AnARmaHnlH9mFWavtXPGlQhAxrTbL9Pz9KZbM+/S2
	 9Kabna9g4VX3M6xGd7ucj+R0EuK4tWvS+3YmUoneoOy17t73XI1r92cfbdedb51nCb49I
	 HTkx/M5DS/89TLq00m8zsf9ufXQpu5ux0ETqucJ+J7svLrjrQ7GaQfx5HoHS/RkVYopal
	 YNTAJT0HgIpFqKq59qzPVM5rnJ1GydPGtwvxkfvPmtP/Bzyd3HTgcukNZj5BYwpgw2WSo
	 SDgIqrrTc0BogBxS0H/ubZh/GTrm4kJgq3s7vQurU4J99Mf0py3jwgTK9GMnir/x/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mg7WZHEZj79IOIo1OCkp+XAthQswPbf623a3uXPb4W4=;
	b=0OHocHVY/GA7WEv+y0Prl4KloqZjuP+AhrzfSEOgsbjDfzm5Jyt+Cx7zRNofoMZNJ8CR
	 AEl5vQgBjmlMunWGNkc2NG8kQ+W1qUQybH6fQIZgBCHTP6c5ia0ocSK7m+ZNcufkp1Ye+
	 fn+0jrp05Z2NhSfGcBwXhb5i9vcyRrxozRxhz/37lV/j97ZuWyWDpFsg9OCBw4tw5m4Dd
	 JX8VBFw0WV+tgchtWYdAUvBvVhsgGonX6hkS9ng0z1ipd48XP24Zr/wHMvHqr03Pg59kb
	 dwawDK9udGcE4w3mEmVtAHmnkv1ayPn5Voxq6o/h1vwoLv1sPTOOU4Ge0x3Z+KGA5dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd1gf4kn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2A606A32C;
	Wed, 21 Oct 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bd1gf4kn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353F21F000C1;
	Wed, 21 Oct 2026 20:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616192;
	bh=Mg7WZHEZj79IOIo1OCkp+XAthQswPbf623a3uXPb4W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bd1gf4kngNb9ifrK1KiIwa0BK83/Bl5xai+J3XZI56JWA5utmZ/WIv4T62t6idGN/
	 zSzYiE33HgKtSEJOZkCcxrV4GzXOtB4l2266cdq1F170OMfKtrHXBseZ6DxM31kp9y
	 ZJPnnaqCr44CUikszfCd9YCuxBqXvWXhnIIaPOXvL6bfnes+YIbxlLgHEE/rlz+QL9
	 R90S7AqP3JDQouku/l+1yBmgnQJ+0ZFSYxY/EPwB9r4eKDbWROIf3ysoHuPC2g8Y+f
	 t44subm8d/Rt9B8xZfvb7pXD3Vigq5qGIqYbZnPcIMdb7FkN1EwJnZlbch0iNP9Arp
	 Hxf+dfY3fEjhA==
Date: Wed, 21 Oct 2026 13:56:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-21
Message-ID: <20261021135631.7c9884eb@kernel.org>
In-Reply-To: <37e1db71-eaeb-40ab-8589-099f9d5611d9@hartkopp.net>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
	<313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
	<37e1db71-eaeb-40ab-8589-099f9d5611d9@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 13:33:38 +0200 Oliver Hartkopp wrote:
> the original PR is pull-request: can-next 2026-10-18
> 
> https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/
> 
> and I had to fix some sashiko-bots reports that didn't show up in 
> previous postings on the CAN mailing list and its LMM.
> 
> So its really just a fixes version of can-next 2026-10-18.

Right, looks like fixes mostly. Could you please quickly look over 
the feedback on patch 11?
