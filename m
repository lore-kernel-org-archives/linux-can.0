Received: from projects.drlauer-research.com (projects.drlauer-research.com [88.99.0.140])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264001E1044
	for <linux-can@vger.kernel.org>; Tue,  8 Oct 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.0.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407127; cv=none; b=oqG1h4cSL/zCljG5wcuzxvg7LoZocUM7tYbOdBViLA3GnwJtf1XsfbFfSRa6Rz7tkd6zQMreU1W7amkjlnW4Rsv8BYskN6Id4EnUNhHXN4HS0g9Eswy0b2AXm9JabW/vvZXUBgnY9Sxvbz3Y7x40Xqznq6716jXLsB0ZyK/xSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407127; c=relaxed/simple;
	bh=G2noBMjTRcmE+16iXF8jRKjD9OKkcvhHFR67GbumJYs=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=ZGlYsumywhSPs4pzgEeTJAttVqdTXhWeySHMiZNMXw27MTonjss7V62a0X+LqCvd4vQPuktoIdi5L0GgefjTSmDiwFZV1Rr3EePXyKoBRNHZoBYtxCGKPDagFHQEn26thIcZVs0XFpnuiF+pfMk72fivrY/ivNlUk2eE14LKz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de; spf=pass smtp.mailfrom=vanille.de; arc=none smtp.client-ip=88.99.0.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanille.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanille.de
Received: from smtpclient.apple (ip-109-090-164-198.um36.pools.vodafone-ip.de [109.90.164.198])
	by projects.drlauer-research.com (Postfix) with ESMTPSA id B20EA480235
	for <linux-can@vger.kernel.org>; Tue,  8 Oct 2024 18:57:10 +0200 (CEST)
From: "Dr. Michael 'Mickey' Lauer" <mickey@vanille.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Predictable network device names for CAN devices
Date: Tue, 8 Oct 2024 18:57:00 +0200
References: <CAO7FjJE-opA-ZHSYOTAw1G1uWpX7Esqj-REid=RVccf_YKJ4vw@mail.gmail.com>
To: linux-can@vger.kernel.org
In-Reply-To: <CAO7FjJE-opA-ZHSYOTAw1G1uWpX7Esqj-REid=RVccf_YKJ4vw@mail.gmail.com>
Message-Id: <15A4B417-3B79-4AF2-8A8D-25ABDAD2A6FC@vanille.de>
X-Mailer: Apple Mail (2.3818.100.11.1.3)

> Could someone provide some details on whether this works, if it is
> possible another way, or if it is possible to submit a feature request
> for a future kernel release?

Does it really need to be a kernel feature? It works fine here via udev =
rules.

Cheers,

:M:=
