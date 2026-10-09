Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9764CB8A1;
	Fri,  9 Oct 2026 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543383; cv=none; b=E3nahe8uO5/+iH5YFA8Xlj8F2QxlRHLoII1sDsYE+Cii2fC2qsf3Qhs4g1zluu8KBd2lgS69whhne5yTfEgqMHttqdqYTs9rCp5AnyK7/I8bGKRxFvC0irEyoaLsKuCS8PfgOYsl8R5Q6y/TbDZAgocXDKXjizaPHv8MrcYcYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543383; c=relaxed/simple;
	bh=sI5us47mzgoN+k0s3b3gUXo1lUt8hbdUvGNorxTwv5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAcvVBz+bMGVgalxYU60MG9JlkJcdKLJtJIR99TYXglYdpP3Azd6fYBavxXMOeR/XQGm433ACzwfOmUmj7KJDolE2aKKYj1GyBo5l59BkCG79hEKpmE3sbmeeUNjhUOku2AliPRUYhP8IMbTkOWGvdyPINSzQ4PZdeRL+5Ma5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IUuXim9F; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IUuXim9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rK
	c4iRyy1NfaB3eGQJkucmqGRWy63t6X3MuOXYYmfPI=; b=IUuXim9FHiW4Ezot/6
	yOfP80N+lVTeI3xUsSYDQk+/XDCR+ukz/nvFXl4yh5N86+I7cOMSMOjO19Se5+GE
	nI4nsAz5uPd8Wyh517Js4BcYX7v8/sN4mNFSHhsDqiQZTd+bRQMi5LpHuiTEmRm5
	tKMfDHgiC1H66ZQkQ9StcrhF0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnjIU9yMhqOLqzDg--.17067S2;
	Fri, 09 Oct 2026 18:55:58 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH 0/2] dt-bindings: net: can: cc770: convert the binding, fix the driver comment
Date: Fri,  9 Oct 2026 18:55:55 +0800
Message-ID: <20261009105557.301855-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCnjIU9yMhqOLqzDg--.17067S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4DZF1rWw4xCr4UCF4Durg_yoWDKFbE9a
	ykAay5J3Z3CFnxKay5Ar47ZrySya1kZrWru3Z8Jw4aq34xWrWDJFn7Jr45Wr1xWFW5ZFnx
	AFyUJay8Cw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAnYrDUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAB4Og2rIyD7AdQAA3y

From: Chaosheng Qu <quchaosheng000406@163.com>

Krzysztof dropped the whole thread from the DT patchwork on 09-15: four
patches went out in one thread and confused the tooling.  This is the
same work, sent as one two-patch series with a cover letter, which is
what Marc asked for on the CAN side.

  [1/2] converts cc770.txt to DT schema.
  [2/2] updates the file name in the comment at the top of the platform
        driver, now that the text binding is gone.

Both carry Assisted-by: LLM, which the first posting was missing, and
neither has been reviewed by anyone yet -- the previous thread was
dropped before that could happen.

Chaosheng Qu (2):
  dt-bindings: net: can: bosch,cc770: Convert to DT schema
  net: can: cc770: update the binding file reference in the driver comment

 Documentation/devicetree/bindings/net/can/bosch,cc770.yaml | 158 +++++++++++++++++++++++++++++++++
 .../devicetree/bindings/net/can/cc770.txt                  | 109 ----------------------
 drivers/net/can/cc770/cc770_platform.c                     |   4 +-
 3 files changed, 155 insertions(+), 57 deletions(-)
-- 
2.43.0

