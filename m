Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B5340DB8;
	Thu, 10 Sep 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048519; cv=none; b=sEVu8XLGfp7V3l+KxYuu8uRDB6I3oU/BXWViIoQ+WiPkInOAQZnYLUd5HIsyJKLJaYExRFVqWFLsbDGI/4KUwY4l3o5ydKsh38rZ0PqI+Rurlk2+gEmdOfmX3ip7MFXiUUut6pcWTBSMGbkz7vQc/V4jPSEjYa9tB/V/zzu7/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048519; c=relaxed/simple;
	bh=WzdZfYwzvaOnvNGbpoxAa4peJEv+nixYbtsph4z7jew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhlv/Hyt/EeBIZ2mQJZVP1DINhwxP+XCm5a1TGUA/X0gP3PBFe/6rn4PZo/XeCL1ROnXor/cvANbFrseVh3Z3K/yH5CKNYqEuwixL6QJWr9E3itJ+5e9fdSup8WWyfIs3Cmd62tCgVcnp73Xewo1ojAxj6dCVIjE5m3ZYD2gd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XiZ8TfT/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XiZ8TfT/"
Received: from mac.lan (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A79AE20B716B;
	Thu, 10 Sep 2026 06:54:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A79AE20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789048476;
	bh=WzdZfYwzvaOnvNGbpoxAa4peJEv+nixYbtsph4z7jew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiZ8TfT/Bs89wNENJ1oPwZC7kJytV68m3thDcW42+DwHjS7B/TfUkGm6awXoGemdS
	 ar63YX15R42K3BTbEB7NrF03+zha5Rol3h8F1UhCcu6orbnduREdWjF3G/qxF6tMQU
	 YoyFo9gS4kvre+IgHN8LJ9FVSNNtX5ENum5fAigI=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: kuba@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	xmei5@asu.edu
Subject: Re: [PATCH net 12/14] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Thu, 10 Sep 2026 09:55:05 -0400
Message-ID: <20260910135505.35748-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827194410.4023800-1-kuba@kernel.org>
References: <20260827194410.4023800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub, Marc,

Sorry for the delayed reply, and thanks for the reviews.

> Would adding the minimum-length check inside
> kvaser_usb_hydra_cmd_size_rx() close this as well, rather than leaving it
> for a follow-up?

Yes, the review was correct. I added generic and command-specific
extended length checks in v4.

v4:
https://lore.kernel.org/all/20260910135000.34796-1-cenzhang@linux.microsoft.com/

Thanks,
Cen
