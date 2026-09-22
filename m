Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CD4C77D9;
	Tue, 22 Sep 2026 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058013; cv=none; b=eYnaD7VMmOeKBEp7LAKgi//BTMuj88DEOe0OVAIB3NX6Auqjnpc2ZCUfh004K/kpZFlV7FZPw/09PBmETkPWwLgMzHmJhxibpF9J/P1MQ4bloy8Xx+QeaTJuCp9Yp/ytvQPhl5Z6PiCLu7EGa+0PqNqRonLab4GTnADVlMZ73CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058013; c=relaxed/simple;
	bh=I/b1rDZSk0Zt8K9ftXS/HCS4tZSIPSJjIYfQxWKaOE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCOBpkPdrctPtxXiXPWJkmnJqu+gG/MZl0CvLjbILiiLtuXqN9jQtjEriNFGVhK4TM2LbfhL9qgW+/N2vu1/NoA0lwOa723iOHuGgX1ai9GdsRZUZxtRVUFL0OsGlBOVGj0WzEeb6y5F+nnmVFUG/DN1N5GVLHbx5waeXBA3MKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hPGzV/IA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hPGzV/IA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I/
	b1rDZSk0Zt8K9ftXS/HCS4tZSIPSJjIYfQxWKaOE8=; b=hPGzV/IAIinv8Fek9u
	17tHscFZsha+c9d2Ibp1bNPW5DjAg9db0eGL8Z7fGo4HMcCozP/9SGkQ9tbNqGZQ
	hk1qDGLZ37/6b6GZnJ53ENIBRzusUl8UXmwfKqjvDbhqE95eQ8DJ24cZzL3VFYTf
	+HDfdv4YIOGio/NLHYHenRszg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXv94KHrJqm20HAw--.43168S2;
	Tue, 22 Sep 2026 14:19:55 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: "To : Conor" <mail@conchuod.ie>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Tue, 22 Sep 2026 14:19:36 +0800
Message-ID: <20260922061945.56511-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <98F28A31-2DAD-45CA-9261-C77E5C10806F@conchuod.ie>
References: <98F28A31-2DAD-45CA-9261-C77E5C10806F@conchuod.ie>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXv94KHrJqm20HAw--.43168S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RppBfUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wvQRmqyHgtTywAA33

Conor,

You're right about that mail, and about the one before it. I was
relaying my replies through a tool instead of writing them.

I'm holding the three CAN bindings. Nothing is queued, and I won't post
a v7 unless Krzysztof or you ask for it. I won't keep going in this
thread either.

Quchaosheng

